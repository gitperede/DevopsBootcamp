terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH for external access"

  ingress {
      description      = "SSH from outside"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
  }
  
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_80"
  description = "Allow 80 for external access to Web"

  ingress {
      description      = "80 from outside"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
  }
  
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_80"
  }
}

resource "aws_security_group" "allow_jenkins" {
  name        = "allow_8080"
  description = "Allow 8080 for external access to Jenkins"

  ingress {
      description      = "8080 from outside"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
  }
  
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_8080"
  }
}


resource "aws_instance" "webserver" {
#  ami                    = "ami-047e03b8591f2d48a"
  ami                    = "ami-05d34d340fb1d89e5"
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.allow_jenkins.id, aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  user_data              = "${file("start_webserver.sh")}"

  tags = {
    Name = "webserver"
  }
}

output "instance_fqdn" {
  value = aws_instance.webserver.public_dns
}
output "instance_ip_addr" {
  value = aws_instance.webserver.public_ip
}
