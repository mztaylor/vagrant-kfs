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

## Steps
- Install ruby, librarian-chef, virtualbox and vagrant
 - suggest using railsinstaller.org for ruby install
 - notes for vagrant found at http://vagrantup.com/v1/docs/getting-started/index.html
 - added chef cookbooks for java, svn, mvn, mysql, tomcat

## Development Steps
These steps are for me as much as anyone to retrace my steps through this process

### Initializing Vagrant environment
    mkdir vagrant-kfs
    cd vagrant-kfs
    vagrant init

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

    touch Cheffile # already included in project
    librarian-chef install
    mkdir scripts
    ## added build-rice.sh

- Notes: Had to modify maven.tar.gz and several dependent repos (OpenSSL, ark, apt)
 - Had issues with the mysql server, investigating
- Installed veewee to build vm from scratch (wanted to bump the memory and include a ui)
 - Found the process of downloading the vm extremely slow
 - TODO: Update notes on building veewee from scratch; gems version is too old
 - TODO: Rename box to include gui to differentiate from standard server

    gem install veewee
    vagrant basebox build 'ubuntu-12.04.1-server-i386'
    vagrant basebox validate 'ubuntu-12.04.1-server-i386'
    vagrant basebox export 'ubuntu-12.04.1-server-i386'
    vagrant add box 'ubuntu-12.04.1-server-i386' ubuntu-12.04.1-server-i386.box

- When setting up unity desktop, include ubuntu-tweak to handle hiding of launcher bar (gets annoying when menus are hidden below it)

