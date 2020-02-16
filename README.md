# EVE-NG automated deployment on DigitalOcean droplet

[EVE-NG](https://www.eve-ng.net) is a clientless network emulator that provides a user interface via a browser. ... It runs commercial network device software on Dynamips and IOU and runs other network devices, such as open-source routers, on QEMU. 

  - This auto deployment uses Terraform, Ansible, Ubuntu 16.04-x64 DigitalOcean Droplet, Python3, and BaSH.

### Prerequisites
  - Modify /etc/environment with the following...
    - DO_PAT=<your digitalocean personal access token.>
    - DO_FP=<your digitalocean allowed ssh key fingerprint>
    - ANSIBLE_HOST_KEY_CHECKING=False

### Setup
  - Modify eve-ng.tf file substituting variables for droplet and domain
  - Create a file called vars.yml with new root password.
    - `touch vars.yml && echo "new_root_pass: "SuperSecretPassword1!""`
  - Modify ansible.cfg lines:
    - privatekeyfile
    - publickeyfile
  - Change DNS name in setup.sh file

### Run
  - `./setup.sh`
  - Answer yes during the Terraform apply stage if everything looks okay.

### Destroy
##### Once your environment needs are complete
  - `./scripts/destroy.sh`

### TODO
- [ ] fix errors in the ansible play to remove "ignore_errors" statements
- [ ] Automate qemu image uploads and installation
- [ ] Setup Let's Encrypt ngnx HTTPS front-end
- [X] Workaround SSH Key Exchange issues and Ansible