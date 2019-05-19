import sys, os, subprocess, boto3, json
from shutil import which

def check_terraform(root):
    if which("terraform") is None:
        scriptpath = root + '/controll-app/src/scripts/install-terraform.sh'
        subprocess.call(scriptpath, shell=True)

def refresh_outputs(root):
    outputs = open(root + '/controll-app/src/data/outputs.json', 'w')
    refresh_log = open(root + '/controll-app/src/log/refresh.log', 'w')
    os.chdir(root + "/terraform/stg")
    subprocess.call(['terraform', 'refresh'], stdout=refresh_log)
    subprocess.call(['terraform', 'output', '-json'], stdout=outputs)

def parse_json(file):
    res = ''
    with open(file, 'r') as f:
        res = json.loads(f.read().replace('\n', ''))
    return res
