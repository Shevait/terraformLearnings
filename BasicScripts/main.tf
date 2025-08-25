# input variables
variable "instance_type" {
    description = "Instance type for the instance"
    default = "t2.micro"
}

variable "ami" {
    description = "AMI ID for the instance"
    default = "ami-0f918f7e67a3323f0"
}

variable "tags" {
    description = "Tags for the instance"
    default = {
        Name = "test_terra"
    }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "test_terra" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = var.tags
}

# output variables
output "public_ip" {
    description = "Public IP of the instance"
    value = aws_instance.test_terra.public_ip
}

output "public_dns" {
    description = "Public DNS of the instance"
    value = aws_instance.test_terra.public_dns
}