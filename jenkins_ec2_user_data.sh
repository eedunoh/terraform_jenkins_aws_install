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


# Install Docker Compose: Docker Compose v2 (binary plugin)

# sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

DOCKER_COMPOSE_VERSION="v2.24.1"
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose


# Install libxcrypt-compat (Amazon Linux 2 requirement)
sudo yum install -y libxcrypt-compat

docker-compose --version

# install git
sudo yum update -y
sudo yum install git -y

# check git version
git --version



# Clone the repo and start docker-compose (replace with your repo)
cd /home/ec2-user
git clone https://github.com/eedunoh/terraform_jenkins_aws_install.git


# Navigate into your Docker Compose files
cd /home/ec2-user/terraform_jenkins_aws_install/dockerfiles


# Change ownership for Jenkins volume directory (this assumes the folder exists already)
sudo mkdir -p /home/ec2-user/jenkins_install
sudo chown -R 1000:1000 /home/ec2-user/jenkins_install


# Sleep to ensure Docker daemon is ready (optional)
sleep 20


# Run your Jenkins and Docker-in-Docker containers
docker-compose up -d