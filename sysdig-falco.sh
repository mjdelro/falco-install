#!/bin/bash
#by mikejdelro (2019)

#---------#
#Functions

#Asks the user yes or no
    function ask {
        # call with a prompt string or use a default
        read -r -p "${1:-Are you sure? [y/N]} " response
        case "$response" in
            [yY][eE][sS]|[yY]) 
                true
                ;;
            *)
                false
                ;;
        esac
    }

#Asks user to press any key to continue
    function continue {
        read -p "Press any key to continue or CTRL+C to abort...";
    }



#---------#
#Initial Update/Upgrade

    ask "Would you like to upgrade your version of Linux?" && sudo apt-get upgrade -y 
        clear 
    ask "Would you like to update your version of Linux?"  && sudo apt-get update -y
        clear

#Install software-properties-common, in case it isn't installed
#Will hopefully install python3, which I will try and use moving forward.
#https://packages.ubuntu.com/bionic/software-properties-common
    ask "Install software-properties-common?" && sudo apt-get install software-properties-common -y 
        clear


#---------#
#Docker

#OS Requirements
    #Provide context of OS requirements
    echo "To install Docker CE, you need the 64-bit version of one of these Ubuntu versions: Cosmic 18.10; Bionic 18.04 (LTS); Xenial 16.04 (LTS)"

    #Python script to provide current platform
    echo "You are currently running:" && python3 -c "import platform;print(platform.platform())"
    continue

#Install Requirements via Apt
    screen -S bash -d -m bash -c "sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y"

#Uninstall previous versions of Docker
    ask "The script will now try to uninstall previous versions of Docker previously installed on your system. Continue?" && sudo apt-get remove docker docker-engine docker.io containerd runc

#Add Docker's official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Add Docker's repository
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && sudo apt-get update

#Install the latest version of Docker CE and containerd
    ask "The script will now install docker-ce docker-ce-cli and containerd. Continue?" && sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    clear

#End of Docker script
echo "The script has finished installing the latest version of Docker"
continue



#---------#
#Installing Falco
    ask "Install Falco?" && sudo docker pull falcosecurity/falco
    screen -S falco -d -m bash -c "docker run -i -t --name falco --privileged -v /var/run/docker.sock:/host/var/run/docker.sock -v /dev:/host/dev -v /proc:/host/proc:ro -v /boot:/host/boot:ro -v /lib/modules:/host/lib/modules:ro -v /usr:/host/usr:ro falcosecurity/falco"
#Install event-generator
    ask "Install Event Generator?" && sudo docker pull sysdig/falco-event-generator
    screen -S eventgen -d -m bash -c "docker run -it --name falco-event-generator sysdig/falco-event-generator"

