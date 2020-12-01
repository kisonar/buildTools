# Gluster FS

## Requirements
```
Install at Ansible Controller manually
ansible-galaxy collection install gluster.gluster

It is also beign done during ansible-playbook run with tag extensions.
```

## Notes
```
Before starting installation fill in /etc/hosts entries related to all cluster nodes

/var/log/glusterfs/*

gluster peer status
gluster pool list
gluster volume info
gluster volume status
gluster peer probe <HOST-NAME>
```

## Installation flow
```
ansible-playbook -i hosts.ini playbook-installation.yml -t="routing"
ansible-playbook -i hosts.ini playbook-services.yml -t="gluster-fs"
```