ansible_ssh_common_args: >-
  -o ProxyCommand="ssh -W %h:%p -q ubuntu@${CONTROL_IP}
  -i ~/.ssh/devops-lab.pem -o StrictHostKeyChecking=no"