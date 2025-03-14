#!/bin/bash

# Update system packages
sudo yum update -y


# Install Docker 
sudo yum install -y docker


# Start Docker service and enable on boot
sudo systemctl start docker
sudo systemctl enable docker


# Add ec2-user to Docker group (so we can use Docker without sudo)
sudo usermod -aG docker ec2-user


# Confirm Docker installed
docker --version


# Optional: Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo yum install -y libxcrypt-compat

docker-compose --version


# Clone the repo and start docker-compose (replace with your repo)
cd /home/ec2-user
git clone https://github.com/eedunoh/terraform_jenkins_aws_install.git
cd /home/ec2-user/terraform_jenkins_aws_install/dockerfiles


# Run your Jenkins and Docker-in-Docker containers
docker-compose up -d