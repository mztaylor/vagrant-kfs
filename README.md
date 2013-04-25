KFS Build on Vagrant
====================
## Introduction
Using this is a starting point for building Rice and KFS from a template script. I would like this project to help
make generating development environments easier (by using a vm, ec2 instance, or chef scripts on their local env).

## Prerequisites 
- Oracle Virtualbox 4.0.12+ (https://www.virtualbox.org/wiki/Downloads)
- Ruby 1.9.x+ (http://www.ruby-lang.org/en/downloads/)
- Vagrant (www.vagrantup.com)
- librarian-chef
- ojdbc14.jar (http://www.oracle.com)

## Steps
- Download oracle 10.2.0.3.0 jdbc driver jar 
 - url: http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html
- Download and install ruby
 - notes: windows users - suggest using railsinstaller.org for ruby install (http://rubyinstaller.org/)
- Install virtualbox
 - url: https://www.virtualbox.org/wiki/Downloads
- Install librarian
 - execute: gem install librarian
- Install vagrant
 - url: http://downloads.vagrantup.com/
- notes:
 - Review vagrant docs found at http://vagrantup.com/v1/docs/getting-started/index.html

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

