# terraform_jenkins_aws_install
A Git repository containing the infrastructure code and configuration files needed to deploy and run Jenkins on AWS.

## Project Structure
  
- **Dockerfile**: Contains instructions for building the Docker image (e.g., install dependencies like Docker CLI, Terraform CLI, and AWS CLI). Jenkins will use these tools to deploy other AWS resources and to ensure CI/CD.

- **docker-compose.yml**: Defines the services (e.g., Jenkins, Docker-in-Docker) and the environment for the containers to run together.


### Terraform Setup

- **jenkins_ec2_user_data.sh**: A shell script that configures the EC2 instance (e.g., installing Jenkins, setting up necessary packages and configurations on instance startup).
  
- **jenkins_iam_role_and_policy.tf**: Defines the IAM role and policies for Jenkins to interact with other AWS services securely (e.g., EC2 accessing S3 to store Terraform state files).
  
- **main.tf**: The main Terraform configuration file, used for provisioning AWS infrastructure:
  - default VPC
  - EC2 instance to host Jenkins
  - Security group for Jenkins
  - S3 remote backend for storing Terraform state files
 
- [Terraform-AWS resources configuration Guide](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
