import sys, os, subprocess, boto3, json
from shutil import which
from classes.funcs import *


if __name__ == "__main__":

    # vars
    proj_root = os.path.normpath(os.path.dirname(os.path.realpath(__file__)) + "/../../")
    pipeline_state = 'down'
    black_hole = open(os.devnull, 'w')
    apply_log = open(proj_root + '/controll-app/src/log/apply.log', 'w')
    init_log = open(proj_root + '/controll-app/src/log/init.log', 'w')
    destroy_log = open(proj_root + '/controll-app/src/log/destroy.log', 'w')
    pipeline_tag_name = 'aim'
    pipeline_tag_value = 'coursework'
    region = 'eu-central-1'
    pipeline_data = ''

    # Pipeline resources
    ec2 = boto3.client(service_name = 'ec2', region_name = region)
    codebuild_client = boto3.client('codebuild', region_name = region)


    #checks
    os.chdir(proj_root + "/terraform/stg")
    provider_setuped = os.path.exists('.terraform/plugins/linux_amd64')
    check_terraform(proj_root)

    #work cyclus
    command = 'init'
    while (True):
        print("\n---Pipeline manager---\nTo exit print 'exit', to get command list print 'help'")
        command = input("input command: ")
        if command == 'exit':
            break
        elif command == 'help':
            print('''\nAvaliale commands:
                \nexit - exit program
                \nhelp - get list of commands
                \nstatus - shows pipeline state and data
                \ncreate - initiate pipeline creating
                \ndestroy - initiate pipeline destruction
                \nstart - power on server with app
                \nstop - power off server with app
                \ndata - shows pipeline data''')
        elif command == 'status':
            print("Pipeline is {}".format(pipeline_state))
        elif command == 'create':
            if pipeline_state == 'down':
                if provider_setuped == False:
                    subprocess.call(["terraform", "init"], stdout=init_log)
                    provider_setuped = True
                subprocess.call(["terraform", "apply", "-auto-approve"], stdout=apply_log)
                pipeline_state = 'up'
                refresh_outputs(proj_root)
                pipeline_data = parse_json(proj_root + '/controll-app/src/data/outputs.json')
                print("Pipeline created")
            else:
                print("Pipeline is {}".format(pipeline_state))
        elif command == 'destroy':
            if pipeline_state == 'up':
                subprocess.call(["terraform", "destroy", "-auto-approve"], stdout=destroy_log)
        elif command == 'data':
            refresh_outputs(proj_root)
            print(open(proj_root + '/controll-app/src/data/outputs.json', 'r').read())
        elif command == 'stop':
            refresh_outputs(proj_root)
            pipeline_data = parse_json(proj_root + '/controll-app/src/data/outputs.json')
            if pipeline_data['server_state']['value'] == 'stopped':
                print('Server is already stopped')
            else:
                ec2.stop_instances(InstanceIds=[pipeline_data['server_instance_id']['value']], DryRun=False)
                print('Server was stopped')
            # ADD A BUILD STOP (HOW TO GET LAST BUILD ID?)
            #print(pipeline_data['build_proj_id']['value'])
            #codebuild_client.stop_build(id = pipeline_data['build_proj_id']['value'])
        elif command == 'start':
            refresh_outputs(proj_root)
            pipeline_data = parse_json(proj_root + '/controll-app/src/data/outputs.json')
            if pipeline_data['server_state']['value'] == 'running':
                print('Server is already running')
            else:
                ec2.start_instances(InstanceIds=[pipeline_data['server_instance_id']['value']], DryRun=False)
                print('Server is now running')


sys.exit

