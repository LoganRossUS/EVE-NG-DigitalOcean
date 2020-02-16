#! /bin/bash

apt update
apt upgrade -y
apt install unzip python3-pip -y
wget -O terraform.zip https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
unzip terraform.zip /usr/local/bin/terraform
rm -rf terraform.zip
python3 -m pip install ansible
./scripts/init.sh
./scripts/plan.sh
./scripts/apply.sh -y
valid_dns="$(nslookup eve-ng.loganross.us)"
rm -rf $HOME/.ssh/known_hosts
while [[ "$valid_dns" == *"NXDOMAIN"* ]];
do
    echo "Waiting on DNS Record to establish..."
    sleep 10
    valid_dns="$(nslookup eve-ng.loganross.us)"
done
ansible-playbook -u root -i eve-ng.loganross.us, install-eve-ng.yml -e 'ansible_python_interpreter=/usr/bin/python3'