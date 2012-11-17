KFS Build on Vagrant
====================
## Introduction
Using this is a starting point for building Rice and KFS from a template script. I would like this project to help
make generating development environments easier (by using a vm, ec2 instance, or chef scripts on their local env).

## Prerequisites 
- Oracle Virtualbox 4.0.12+
- Ruby 1.9.x+
- Vagrant (www.vagrantup.com)
- Chef Solo (www.opscode.com TBD)
- Veewee 0.30+ (https://github.com/jedi4ever/veewee)
- librarian-chef
- ojdbc14.jar (download from oracle.com)

## Steps
- Install ruby, librarian-chef, virtualbox and vagrant
- Download oracle 10.2.0.3.0 jdbc driver jar 
 - suggest using railsinstaller.org for ruby install
 - notes for vagrant found at http://vagrantup.com/v1/docs/getting-started/index.html
 - added chef cookbooks for java, svn, mvn, mysql, tomcat

### Setup process

     git clone https://github.com/mztaylor/vagrant-kfs.git
     cd vagrant-kfs
     cp ~/.m2/repository/com/oracle/ojdbc14/10.2.0.3.0/ojdbc14-10.2.0.3.0.jar ./cookbooks/rice/files/default/ojdbc14.jar
     librarian-chef install
     vagrant up


## Todo
- Fix permission issues
- Find workaround for missing oracle jdbc jar
- Deploy rice on tomcat server
- Determine how much work to setup project in intellij/eclipse via command line/scripting
- Get kfs up and running
- refactor and document

