#!/bin/bash

#lvextend -L +1G /dev/mapper/vg01-opt -r
#lvextend -L +1G /dev/mapper/vg01-usr -r

sudo apt update
sudo apt upgrade -y

#clean
sudo apt purge *libreoffice* -y

#gsettings set org.gnome.desktop.interface scaling-factor 2

sudo apt install remmina-plugin-rdp remmina-plugin-vnc remmina-plugin-secret freerdp2-x11 remmina -y
sudo apt install scdaemon mc -y
sudo apt install network-manager-fortisslvpn network-manager-fortisslvpn-gnome openfortivpn -y
sudo apt install linux-image-extra-virtual -y
sudo apt autoremove -y

#Java for iDRAC6 install
sudo apt purge icedtea*
sudo apt purge *openjdk* -y
sudo apt purge oracle-java11-* -y
sudo apt autoremove --purge -y
sudo apt update && sudo apt install openjdk-8-jdk
sudo apt install icedtea*
# Comment all line in /etc/java-11-openjdk/security/java.security with disabled algorithms:
# sudo vim /etc/java-11-openjdk/security/java.security

#echo 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:3440x1440"'
#sudo sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash/& video=hyperv_fb:3440x1440/" /etc/default/grub
#sudo update-grub

#echo "blacklist hyperv_fb" >> /etc/modprobe.d/blacklist.conf

df -h
pvdisplay
lvdisplay
