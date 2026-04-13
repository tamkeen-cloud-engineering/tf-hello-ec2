provider "aws" {
  region  = "us-east-1"
  profile = "sandbox"
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-2023.11.20260406.2-kernel-6.18-x86_64"]
  }
}

output "latest_amazon_linux_ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

resource "aws_instance" "server" {
  # ami         = "ami-040e10ddbaf780d2f" 
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"

  tags = {
    Name = "jsrn-server"
    ManagedBy = "Terraform"
  }
}
