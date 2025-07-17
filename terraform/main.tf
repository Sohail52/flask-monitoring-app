provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "flask_sg" {
  name        = "flask_security_group"
  description = "Allow inbound traffic for Flask, Prometheus, and Grafana"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5001
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
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

resource "aws_instance" "flask_server" {
  ami           = "ami-03bb6d83c60fc5f7c"
  instance_type = "t2.micro"
  key_name      = "new-flask-key"
  security_groups = [aws_security_group.flask_sg.name]

  tags = {
    Name = "FlaskAppServer"
  }
}

output "public_ip" {
  value       = aws_instance.flask_server.public_ip
  description = "Public IP address of the Flask EC2 instance"
}