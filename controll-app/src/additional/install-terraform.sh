#!/bin/bash

sudo apt-get install -y unzip
wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
unzip terraform_0.11.13_linux_amd64.zip
mv terraform /usr/local/bin/
rm -f terraform_0.11.13_linux_amd64.zip
