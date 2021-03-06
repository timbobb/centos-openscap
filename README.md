GovReady centos-openscap
=============================

# Status

| Date         | Status | Time to Build |
|--------------|-------------|-------------|
| May 23, 2014 Created| Build OK. openSCAP OK. | About 10 minutes or less |

A Virtual Machine for Exploring openSCAP on CentOS

## Goals

Help others learn about openSCAP on CentOS

## About this Virtual Machine

This repo contains a Vagrant file and Ansible Playbook to automatically configure a CentOS 6.4 64-bit virtual machine.

## Background

RHEL involves licenses. To do simple learning, it's best to have an open source computer that is also does not have up front costs.

## Requirements
This repo uses Vagrant and VirtualBox to instantiate a virtual machine running CentOS 6.4.

Requirements:
- VirtualBox (http://virtualbox.org)
- Vagrant (http://vagrantup.com)

## Instructions
After you install VirtualBox and Vagrant, clone this repository and run `vagrant up`.

Remember to first `cd` into the directory where you want to save this repo!

```
git clone git@github.com:GovReady/centos-openscap.git
cd centos-openscap
vagrant up
# Watch as everything is installed in about 10 minutes.
```

You can now log into your running CentOS with openSCAP and SSG installed.
```
vagrant ssh
```

## Manual installation of openSCAP and SCAP Security Guide

Step 1. Log into your server running CentOS 6.4. If a command does not work, run with `sudo`

Step 2. Add epel RPM repository CentOS 6
```
su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'
```
Alternatively:
```
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
```

Step 3. Install openSCAP
```
yum install -y openscap openscap-utils openscap-content
```

Step 4. Install SCAP Security Guide
```
yum -y install scap-security-guide
```

## Running openSCAP system scan
Here's an example of running openSCAP against the 

```
cd ~/
oscap xccdf eval --profile usgcb-rhel6-server \
	--results ~/usgcb-rhel6-server.xml \
	--report ~/usgcb-rhel6-server.html \
	--cpe /usr/share/xml/scap/ssg/content/ssg-rhel6-cpe-dictionary.xml \
	/usr/share/xml/scap/ssg/content/ssg-rhel6-xccdf.xml ; true

```

# Additional
There is a simple landing page at `http://localhost:8080/govready` that corresponds to the CentOS directory `/var/www/govready-html`.

## Links

### Ansible
* [Jeff Geerling Slides](http://www.slideshare.net/geerlingguy/local-development-on-virtual-machines-vagrant-virtualbox-and-ansible)
* [Ansible's Example on GitHub](https://github.com/ansible/ansible-examples/tree/master/lamp_simple)
* [Julian Ponge post with examples](http://julien.ponge.org/blog/scalable-and-understandable-provisioning-with-ansible-and-vagrant/)
* [Ansible docs on using Vagrant](http://docs.ansible.com/guide_vagrant.html)
* [Vagrant docs on using Ansible](http://docs.vagrantup.com/v2/provisioning/ansible.html)
* [Getting Cirrius example of Ansible and Firewall rules](http://www.gettingcirrius.com/2013/11/configure-iptables-with-ansible.html)
* [CentOS wiki EC2 and Ansible](http://wiki.centos.org/Cloud/Manage/Ansible)

More on Ansible
* Ansible executes in order.
* Ansible playbook needs to address `hosts`, `vars`, `handlers`, and `tasks`. 
* Variable substitution in Ansible `{{ var_name }}` 
* Ansible loop you indicate the command and then add `with_items` YAML list. 
* Ansible copy file by defaults copies `src` from Ansible computer to `dest` on guest (target) server. You can set mode and ownership
* Copying files really is an easy way manage firewalls and vhost configurations.
