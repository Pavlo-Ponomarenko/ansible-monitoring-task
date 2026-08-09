[targets]
target-1 ansible_host=${TARGET1_IP}
target-2 ansible_host=${TARGET2_IP}
target-3 ansible_host=${TARGET3_IP}
[control]
control-node ansible_host=${CONTROL_IP}
[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/devops-lab.pem
ansible_host_key_checking=False