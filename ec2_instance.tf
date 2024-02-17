#Provider Plugin Details
#=======================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
#######VARIABLES##########
##########################
#Region:
variable "a_infra_region" {
  type        = string
  description = "Please enter the region where you want to create infra: "
}
#Access Key:
variable "b_access_key" {
  type        = string
  description = "Please enter the access key:  "
  sensitive = true
}
#Secret Access Key:
variable "c_secret_key" {
  type        = string
  description = "Please enter the secret key:  "
  sensitive = true
}
#ServerName:
variable "d_server_name" {
  type        = string
  description = "Please enter the ServerName: "
}
#image:
variable "e_image_id" {
  type        = string
  description = "Please enter the operating system image id: "
}
#instance_type:
variable "f_instance_type" {
  type        = string
  description = "Please enter the server configuration/instance type:"
}
#key-pair:
variable "g_key_pair" {
  type        = string
  description = "Please enter the keypair to connect to the server: "
}
# Ports
variable "h_port" {
    type = string
    description = "Please enter the port number"
}


##########################
##########################


#Provider Details
#================
provider "aws" {
  region     = var.a_infra_region
  access_key = var.b_access_key
  secret_key = var.c_secret_key
}
#Resource Details
#================
resource "aws_instance" "web" {
  ami           = var.e_image_id
  instance_type = var.f_instance_type
  vpc_security_group_ids = [ aws_security_group.securitygrp1.id ]


  tags = {
    Name = var.d_server_name
  }
}
resource "aws_security_group" "securitygrp1" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  

  tags = {
    Name = "ssh-port"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.securitygrp1.id
   cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.h_port
  ip_protocol       = "tcp"
  to_port           = var.h_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.securitygrp1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


