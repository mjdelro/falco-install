#!/bin/bash
#by mikejdelro (2019)

#---------#
#Functions

#Asks the user yes or no
ask() {
    local prompt default reply
    if [ "${2:-}" = "Y" ]; then
        prompt="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        prompt="y/N"
        default=N
    else
        prompt="y/n"
        default=
    fi
    while true; do
        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "
        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty
        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi
        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}

#Asks user to press any key to continue
function continue {
    read -p "Press any key to continue or CTRL+C to abort...";
}



#---------#
#Initial Update/Upgrade

ask "Would you like to upgrade your version of Linux?" && sudo apt-get upgrade -y && clear 
ask "Would you like to update your version of Linux?" && sudo apt-get update -y && clear

#Install software-properties-common, in case it isn't installed
#Will hopefully install python3, which I will try and use moving forward.
#https://packages.ubuntu.com/bionic/software-properties-common
check "Install software-properties-common" && sudo apt-get install software-properties-common -y 



#---------#
#Docker

#OS Requirements
    #Provide context of OS requirements
    echo "To install Docker CE, you need the 64-bit version of one of these Ubuntu versions: Cosmic 18.10; Bionic 18.04 (LTS); Xenial 16.04 (LTS)"

    #Python script to provide current platform
    echo "You are currently running:" && python3 -c "import platform;print(platform.platform())"
    continue

#Install Requirements via Apt
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

#Uninstall previous versions of Docker
ask "The script will now try to uninstall previous versions of Docker previously installed on your system. Continue?" && sudo apt-get remove docker docker-engine docker.io containerd runc

#Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Add Docker's repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#Update Apt with included Docker repository
sudo apt-get update

#Install the latest version of Docker CE and containerd
ask "The script will now install docker-ce docker-ce-cli and containerd. Continue?" && sudo apt-get install docker-ce docker-ce-cli containerd.io -y && clear

echo "The script has finished installing the latest version of Docker"
continue



#---------#
#Installing Falco

