#!/bin/bash

apt-get -qq update


set -eu -o pipefail # fail on error , debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo priveledge to run this script"

echo installing the must-have pre-requisites
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
    vim
    tcpdump
    screen
    unrar
    htop
    net-tools
    sshpass
    dos2unix
    expect
    openssh-server
    openssh-client
    openvpn
    ntp
    curl
    apache2
    nodejs
    git
    docker
    python-pip
    nmap
    vsftpd
EOF
)
