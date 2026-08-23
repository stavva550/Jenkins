provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web-server1" {
  ami           = "ami-06475e8f54266e38e"
  instance_type = "t3.micro"
  user_data = file("userdata.sh")
  tags = {
    Name = "webserver1"
  }
}

resource "aws_security_group" "mySG" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  # Ingress
  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Egress
  dynamic "egress" {
    for_each = var.egress_rules

    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "jenkins-sg"
  }
}