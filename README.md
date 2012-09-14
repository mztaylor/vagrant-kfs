KFS Build on Vagrant
====================
## Introduction
This is a starting point for building KFS instantly, allowing new developers 
to get a working instance of KFS (and potentially other Kuali products) 

## Prerequisites 
- Oracle Virtualbox 4.0.12+
- Ruby 1.9.x+
- Vagrant (www.vagrantup.com)
- Chef Solo (www.opscode.com TBD)

## Steps
- Install ruby, virtualbox and vagrant
-- notes found at http://vagrantup.com/v1/docs/getting-started/index.html
-- added chef cookbooks for java, svn, mvn, mysql, tomcat
- Next step: fixing recipe for mysql server

## Development Steps

### Initializing Vagrant environment
- mkdir vagrant-kfs; cd vagrant-kfs
- vagrant init

### Build basic box (precise32 - Ubuntu 12.04 LTS)
    vagrant box add precise32 http://files.vagrantup.com/precise32.box
(edit vagrant file: modify config.vm.box "precise32")
   vagrant up
    vagrant halt

### Save work to git

    git init
    git add .
    git commit -m "basic box setup"

### Add new directories for chef scripts (for mvn,svn,java,tomcat) and scripts (for kr/kfs)

    mkdir cookbooks
    mkdir scripts

