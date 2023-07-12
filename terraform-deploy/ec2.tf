resource "aws_security_group" "sg_grafana" {
  name        = "allow_ssh_http_grafana"
  description = "Allow ssh http inbound traffic"

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh_http_grafana"
  }
}

resource "aws_instance" "app_server" {
  ami           = var.packer_ami_id
  instance_type = "t2.micro"
  key_name = "paulalab"
 
  vpc_security_group_ids = [
    aws_security_group.sg_grafana.id
  ]

  tags = {
    Name = var.instance_name
  }

  depends_on = [ aws_security_group.sg_grafana ]
  
}