import sys, os, subprocess, boto3
from shutil import which

def check_terraform(root):
    if which("terraform") is None:
        scriptpath = root + '/controll-app/src/additional/install-terraform.sh'
        subprocess.call(scriptpath, shell=True)

if __name__ == "__main__":

    # vars
    proj_root = os.path.normpath(os.path.dirname(os.path.realpath(__file__)) + "/../../")
    pipeline_state = 'down'
    black_hole = open(os.devnull, 'w')
    pipeline_tag_name = 'aim'
    pipeline_tag_value = 'coursework'
    ec2 = boto3.resource('ec2')
    tomcat_server
    for instance in ec2.instances.all():
        for tag in instance.tags:
            if tag['Key'] == pipeline_tag_name and tag['Value'] == pipeline_tag_value:
                tomcat_server = instance

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
                \ndestroy - initiate pipeline destruction''')
        elif command == 'status':
            print("Pipeline is {}".format(pipeline_state))
        elif command == 'create':
            if pipeline_state == 'down':
                if provider_setuped == False:
                    subprocess.call(["terraform", "init"], stdout=black_hole)
                    provider_setuped = True
                subprocess.call(["terraform", "apply", "-auto-approve"], stdout=black_hole)
                pipeline_state = 'up'
                print("Pipeline created")
            else:
                print("Pipeline is {}".format(pipeline_state))
        elif command == 'destroy':
            if pipeline_state == 'up':
                subprocess.call(["terraform", "destroy", "-auto-approve"], stdout=black_hole)
        #elif command == 'data':
            #for resourse in boto3.resource.all
        elif command == 'stop':
            tomcat_server.stop()
        elif command == 'start':
            tomcat_server.start()
sys.exit

