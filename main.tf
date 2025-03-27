terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}


# We will use the default (existing) vpc. We dont want to create another one
data "aws_vpc" "existing_vpc" {
  filter {
    name   = "is-default"
    values = ["true"]   # Set to "false" if you're using a non-default VPC
  }
}


# We are extracting the subnet from the default vpc
data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]  # Fetch subnets from the default (existing) VPC
  }
}


resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and Jenkins"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "jenkins" {
  ami                    = "ami-016038ae9cc8d9f51"      # Amazon Linux 2
  instance_type          = "t3.medium"                   # or whatever type you want
  key_name               = "webapp1key"                 # this is an already existing key on my aws account
  
  instance_initiated_shutdown_behavior = "terminate"

  associate_public_ip_address = true
  
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  
  availability_zone = "eu-north-1a"
  
  # IAM instance profile (needed for jenkins access to s3)   
  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name
  
  user_data = base64encode(file("jenkins_ec2_user_data.sh")) # Bootstrap script to install and run Jenkins

  tags = {
    Name = "Jenkins-Server"
  }
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "app-remote-state-bucket-fyi"
}


output "jenkins_url" {
  description = "Jenkins URL"
  value       = "http://${aws_instance.jenkins.public_ip}:8080"
}
