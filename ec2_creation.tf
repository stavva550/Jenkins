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