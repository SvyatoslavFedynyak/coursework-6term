import sys, os, subprocess, boto3

ec2 = boto3.resource('ec2')

for instance in ec2.instances.all():
    print(instance.private_dns_name)
    for tag in instance.tags:
        if tag['Key'] == 'aim' and tag['Value'] == 'coursework':
            print(instance.id)
            instance.start()
sys.exit