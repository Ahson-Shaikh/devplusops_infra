### DevOps Assessment Task

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#devops-assessment-task)

#### Overview

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#overview)

This task is designed to evaluate your DevOps automation skills, infrastructure creation capabilities, and programming knowledge. You are required to complete this task within 3-4 hours. The task is divided into two parts:

1. **Infrastructure Automation (Cloud-based)**
2. **Programming Task**

#### Part 1: Infrastructure Automation (Cloud-based)

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#part-1-infrastructure-automation-cloud-based)

##### Objective:

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#objective)

Set up a basic web application infrastructure on AWS using Infrastructure as Code (IaC) tools.

##### Requirements:

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#requirements)

1. **Provisioning Infrastructure:**
   - Use Terraform to create the infrastructure.
   - The infrastructure should include the following components:
     - A VPC with public and private subnets across two availability zones.
     - An Internet Gateway and corresponding route tables to allow internet access for resources in the public subnet.
     - A public-facing Load Balancer.
     - An EC2 instance (in the public subnet) running a simple web server (e.g., Nginx).
     - An RDS instance (in the private subnet) running MySQL.
2. **Configuration Management:**
   - Use Ansible to configure the EC2 instance.
   - The Ansible playbook should:
     - Install Nginx on the EC2 instance.
     - Deploy a simple HTML page that says "Hello, World!".
     - Configure Nginx to serve the HTML page.
3. **Networking and Security:**
   - Ensure security groups are set up to allow:
     - HTTP and HTTPS traffic to the Load Balancer.
     - SSH access to the EC2 instance from a specific IP (your IP).
     - MySQL access to the RDS instance only from the EC2 instance.

##### Deliverables:

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#deliverables)

- Terraform scripts to create the infrastructure.
- Ansible playbook to configure the EC2 instance.
- A brief README.md file explaining:
  - How to set up and run the Terraform scripts.
  - How to run the Ansible playbook.
  - Any assumptions made.

#### Part 2: Programming Task

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#part-2-programming-task)

##### Objective:

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#objective-1)

Write a small application that interacts with the infrastructure you created in Part 1.

##### Requirements:

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#requirements-1)

1. **Language:**
   - You can use Python or Node.js for this task.
2. **Application Functionality:**
   - The application should connect to the MySQL database hosted on RDS.
   - Create a table `visitors` with columns `id`, `name`, and `visit_time`.
   - Implement two functionalities:
     - A POST endpoint to add a visitor's name to the table.
     - A GET endpoint to retrieve a list of all visitors.
3. **Testing:**
   - Include unit tests for the application.
   - Use a testing framework of your choice (e.g., pytest for Python, Mocha for Node.js).

##### Deliverables:

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#deliverables-1)

- Source code of the application.
- Unit tests for the application.
- A brief README.md file explaining:
  - How to set up and run the application.
  - How to run the tests.

#### Submission Instructions:

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#submission-instructions)

- Create a GitHub repository and upload all your code there.
- Provide the repository link along with any necessary instructions for running your solution.

### Evaluation Criteria:

[](https://gist.github.com/ahsang/85a34e1b76a2b852d9e3269e06221015#evaluation-criteria)

- **Correctness and completeness** : Does the solution meet the requirements?
- **Code quality** : Is the code well-structured, readable, and maintainable?
- **Documentation** : Are the instructions clear and comprehensive?
- **Efficiency** : Is the infrastructure set up efficiently with minimal resource wastage?
- **Testing** : Are the unit tests comprehensive and do they cover key functionalities?

Good luck!
