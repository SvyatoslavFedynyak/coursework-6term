import sys, os, subprocess, boto3

region = 'eu-central-1'
codebuild_client = boto3.client('codebuild', region_name = region)
print(codebuild_client.stop_build(id='coursework-app-builder'))

sys.exit