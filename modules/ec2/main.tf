resource "aws_instance" "web" {
  ami           = data.aws_ami.rhel_9.id
  instance_type = var.instance_type

  iam_instance_profile = var.iam_instance_profile_name

  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.allow_public_ip_address

  user_data = <<EOF
  #!/bin/bash
  dnf update -y
  subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
  dnf install -y 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm'

  # Install SSM Agent
  cd /tmp
  yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
  systemctl enable amazon-ssm-agent
  systemctl start amazon-ssm-agent

  # Add user
  groupadd mcharles -g 111682
  useradd -c 'Charles, Max ,IT,111682,'`date +"%Y-%m-%d"`'' -u 111682 -g users -d /home/mcharles -s /bin/bash -m mcharles
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
  EOF
  root_block_device {
    delete_on_termination = true
    volume_size           = var.volume_size
    volume_type           = var.volume_type

    tags = {
      Name        = var.instance_name
      Application = var.application_name
      CreatedBy   = var.user_name
      Environment = var.environment
    }
  }

  tags = {
    Name        = var.instance_name
    Application = var.application_name
    CreatedBy   = var.user_name
    Environment = var.environment
  }
}

resource "aws_eip" "web_eip" {
  instance = aws_instance.web.id
}
