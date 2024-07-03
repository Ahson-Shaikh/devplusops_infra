terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.56.1"
    }
  }
}

provider "aws" {

}

resource "aws_vpc" "devplusops_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devplusops_vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.devplusops_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.devplusops_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2b"

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.devplusops_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2c"

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.devplusops_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_network_interface" "devplusops_network_interface" {
  subnet_id   = aws_subnet.public.id
  security_groups = [aws_security_group.web_sg.id]
  private_ips = ["10.0.1.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.devplusops_vpc.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.devplusops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}


resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.devplusops_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["39.34.146.110/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_security_group" "lb-sg" {
  vpc_id = aws_vpc.devplusops_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb-sg"
  }
}


resource "aws_instance" "devplusops_instance" {
  ami           = "ami-0f30a9c3a48f3fa79" 
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"

  network_interface {
    network_interface_id = aws_network_interface.devplusops_network_interface.id
    device_index         = 0
  }
  user_data = file("script.sh")

}

resource "aws_lb_target_group" "target_group" { 

 name     = "target-group-a"
 port     = 80
 protocol = "HTTP"
 vpc_id   = aws_vpc.devplusops_vpc.id

}

resource "aws_lb_target_group_attachment" "target_group_attachment" {

 target_group_arn = aws_lb_target_group.target_group.arn
 target_id        = aws_instance.devplusops_instance.id
 port             = 80

}

resource "aws_lb" "devplusops_alb" {

 name               = "devplusops-alb"
 internal           = false
 load_balancer_type = "application"
 security_groups    = [aws_security_group.lb-sg.id]
 subnet_mapping {
    subnet_id = aws_subnet.public.id
  }
 subnet_mapping {
    subnet_id = aws_subnet.public2.id
  }

 tags = {
   Environment = "dev"
 }
}

resource "aws_lb_listener" "devplusops_alb_listener" {

 load_balancer_arn = aws_lb.devplusops_alb.arn
 port              = "80"
 protocol          = "HTTP"

 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.target_group.arn
 }
}

resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = [aws_subnet.private.id, aws_subnet.private2.id]

  tags = {
    Name = "main-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.devplusops_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}


resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "mydb"
  username             = "admin"
  password             = "password"
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "mysql-db"
  }
}


output "lb_dns_name" {
  value = aws_lb.devplusops_alb.dns_name
}



# resource "aws_instance" "web" {
#   ami           = "ami-0c55b159cbfafe1f0" 
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.public.id
#   security_groups = [aws_security_group.web_sg.name]

#   network_interface {
#     network_interface_id = aws_network_interface.devplusops_network_interface.id
#     device_index         = 0
#   }

#   user_data = <<-EOF
#               #!/bin/bash
#               apt update
#               amazon-linux-extras install nginx1 -y
#               systemctl start nginx
#               systemctl enable nginx
#               echo "Hello, World" > /usr/share/nginx/html/index.html
#             EOF

#   tags = {
#     Name = "web-server"
#   }
# }


