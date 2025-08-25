provider "aws" {
    region = "ap-south-1"
}



resource "aws_instance" "test_terra" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = var.tags
}