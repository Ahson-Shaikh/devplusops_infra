# Terraform Project

## Overview

This project helps create the desired infrastructure as it was requested by the DevPlusOps team. This create the following items.

1. **VPC** **with 4 subnets (2 Public and 2 Private)** -> The requirement was for only one public and one private subnet but, the resources I needed to provision required Multi-AZ setup and I couldn't place public resources in private subnets. That would have conflicted with other requirements.
2. **EC2 instance** -> Placed insdie the the public subnets.
3. **RDS instance** -> Placed inside the private subnets.
4. **Application Load Balancer** -> External forwading traffic to the EC2 target groups.

Meanwhile other resources are also provisioned -> SG, RDS-SG, TG, ALB-Listerners.

The RDS (MySQL) instance can communicate with the EC2 instance on 3306, since the RDS-SG allows ingress from internal VPC CIDR.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed Terraform. If not, follow the instructions below.

## Installation

1. **Download Terraform:**

   - Visit the [Terraform download page](https://www.terraform.io/downloads.html).
   - Choose the appropriate package for your operating system.

2. **Install Terraform:**

   - For **macOS** users, you can install Terraform using Homebrew:
     ```sh
     brew tap hashicorp/tap
     brew install hashicorp/tap/terraform
     ```
   - For **Windows** users, you can use Chocolatey:
     ```sh
     choco install terraform
     ```
   - For **Linux** users, extract the downloaded package to `/usr/local/bin`:
     ```sh
     unzip terraform_<version>_linux_amd64.zip
     sudo mv terraform /usr/local/bin/
     ```

3. **Verify Installation:**

   - Open a terminal and type:
     ```sh
     terraform --version
     ```
   - You should see the installed version of Terraform.

## Usage

1. **Initialize the project:**

   - Navigate to your project directory and run:
     ```sh
     terraform init
     ```

2. **Plan the infrastructure:**

   - Create an execution plan to preview the changes that Terraform will make:
     ```sh
     terraform plan
     ```

3. **Apply the configuration:**

   - Apply the changes required to reach the desired state of the configuration:
     ```sh
     terraform apply
     ```
