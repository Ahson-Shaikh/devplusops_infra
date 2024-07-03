# Ansible Steps For DevPlusOps Team

## Overview

This Ansible playbook is designed to configure an EC2 instance by installing and setting up Nginx, a popular web server. The playbook performs the following tasks:

1. Installs Nginx.
2. Starts and enables the Nginx service.
3. Moves the `index.html` file from the template folder.
4. Ensures the Nginx service is running and restarts it if necessary.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed Ansible. If not, follow the instructions below.

## Installation

1. **Install Ansible:**

   - For **macOS** users, run the following command.
     ```sh
     brew install ansible
     ```
   - For **Linux** users, run the following command.
     ```sh
     sudo apt update
     sudo apt install ansible -y
     ```

2. **Verify Installation:**

   - Open a terminal and type:
     ```sh
     ansible --version
     ```
   - You should see the installed version of Ansible.

## Usage

1. **Update the inventory file**

   - Navigate to the invetory file and add the remote machine IP.

2. **Enable Key Based Access:**

   - Add your System's Public Key in the authorized_keys file of your remote machine and test by doing SSH.

3. **Run the Playbook:**

   - Run the playbook while using the inventory.
     ```sh
     ansible-playbook -i inventory playbook.yml
     ```
