#Provider Plugin Details
   #Get it from registry.terraform.io
#Provider Details
   #Add access and secret keys
#Resource Details
   #Add resource details
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region     = "eu-north-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "Server1"
  }
}