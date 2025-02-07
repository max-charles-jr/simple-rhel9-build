#!/bin/bash

dnf update
sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
sudo dnf install 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm'

# Add user
groupadd mcharles -g 111682
useradd -c 'Charles, Max ,IT,211557,'`date +"%Y-%m-%d"`'' -u 111682 -g users -d /home/mcharles -s /bin/bash -m mcharles
usermod -aG wheel mcharles 
sed -i.bak /mcharles/d /etc/shadow
echo 'mcharles:$6$sKuScb3J$P2VTXhh58xrgJZCqjeLYUEiNtOkB4M1yMnH0AvNOCV5Fxt0HGo8F6/Ukd74zxRc9CHEUWpHQVah/ZKJdFkqe9.:18304:0:99999:7:::' >> /etc/shadow 
chmod 700 /home/mcharles
mkdir /home/mcharles/.ssh
chown -R mcharles:mcharles  /home/mcharles/.ssh
chmod 700 /home/mcharles/.ssh
touch /home/mcharles/.ssh/authorized_keys
chown -R mcharles:mcharles  /home/mcharles/.ssh/authorized_keys
chmod 600 /home/mcharles/.ssh/authorized_keys
echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClmU/FJYSim+NZuOSgtR8d/kLsWYmtKNT9PkR5qRdOcOyLFTrHUcXOje0LH8/g0tqdpu2rRH0qykJ/OBXKmWtSPJUwm4fvZaipmnLt358uerBbQ4ITtvkSBtABqSLmdHPf6l9fSJyfAETXCFawmhKBtScq7HPOLbDTcOeRAKNjPiZQGEjmXnsiSCR0TG1lvRahpurqyifq0rlz7RQb+LgBTOOJX7HNvdtkVamS6RM+QbAbS1PjywBNPOPVT/yM6WkwPEvUJwa37EtFIVxNj2r7vMBXvyD+RPGPov37W6VulW5/6ofY3eOtACrVOl4CVMdyX7n05BEIB5ZkXSXbFJrH max@maxmacbookpro2.local > /home/mcharles/.ssh/authorized_keys