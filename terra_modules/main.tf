provider "aws" {
    region = "ap-south-1"
}

module "ec2-instance" {
    source = "./modules/ec2-instance"
    instance_type = "t2.micro"
    ami = "ami-0f918f7e67a3323f0"
    tags = {
        Name = "test_terra"
    }
}
