# terraform_jenkins_aws_install
A Git repository containing the infrastructure code, configuration files, and automation scripts needed to deploy and run Jenkins on AWS.


**Dockerfile:** Contains instructions for building the Docker image (e.g., install dependencies like Dokcer CLI, Terraform CLI and AWS CLI). Jenkins will use these tools to deploy other AWS resources and to ensure CI/CD.




**Docker-compose.yml:** Defines the services (e.g., Jenkins, Docker-in-Docker) and the environment for the containers to run together.




**Jenkins_ec2_user_data.sh:** A shell script that configures the EC2 instance (e.g., installing Jenkins, setting up necessary packages and configurations on instance startup).



**Jenkins_iam_role_and_policy.tf:** Defines the IAM role and policies for Jenkins to interact with other AWS services securely (e.g., ec2 accessing S3 to store terraform state files).




**main.tf:** The main Terraform configuration file, used for provisioning AWS infrastructure (e.g., EC2 instance that will host Jenkins, networking, security, s3 for remote backend and more).
