 # Terraform Project

## Overview

This project is designed to help you manage your infrastructure using Terraform. Terraform is an open-source infrastructure as code software tool that enables you to safely and predictably create, change, and improve infrastructure.

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


