Flask Application with Terraform and Ansible

This project sets up a Flask application that connects to an RDS MySQL database. It uses Terraform to create the required AWS infrastructure and Ansible to configure the EC2 instance running the application.
Prerequisites

    Terraform installed on your system.
    Ansible installed on your system.
    AWS account with necessary permissions to create resources.

AWS Infrastructure Setup using Terraform
Step 1: Configure AWS Credentials

Set up your AWS credentials. You can use environment variables for Terraform to authenticate:

sh

export AWS_ACCESS_KEY_ID="<your_key_id>"
export AWS_SECRET_ACCESS_KEY="<your_secret_key>"
export AWS_REGION="<your_region>"

Step 2: Initialize Terraform

Initialize Terraform with the following command:

sh

terraform init

Step 3: Plan and Apply Terraform Configuration

Generate and review the execution plan:

sh

terraform plan

If the plan looks good, apply the configuration to create the resources:

sh

terraform apply

EC2 Instance Configuration using Ansible
Step 1: Prepare SSH Access

Add your public SSH key to the authorized_keys file of your Linux system:

sh

ssh-copy-id -i ~/.ssh/id_rsa.pub <user>@<host>

Step 2: Configure Ansible Inventory

Add the public IP of your EC2 instance to the inventory file in the Ansible directory and adjust variables if necessary:

ini

[web]
<your_ec2_public_ip> ansible_user=ubuntu ansible_private_key_file=~/.ssh/id_rsa

Step 3: Run Ansible Playbook

Navigate to the Ansible directory and run the playbook:

sh

ansible-playbook -i inventory playbook.yml

Flask Application
Application Functionality

The Flask application connects to a MySQL database hosted on RDS. It provides two endpoints:

    POST /add_visitor: Adds a visitor's name to the visitors table.
    GET /visitors: Retrieves a list of all visitors.
