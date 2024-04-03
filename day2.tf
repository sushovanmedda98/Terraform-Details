variable "ami_value" {
    description = "value for ami"
  
}

variable "instance_type_value" {
    description = "value for instance"
  
}

variable "subnet_id_value" {
    description = "value for subnet"
  
}
variable "key_name_value" {
    description = "value for key"
  
}



provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "example" {
    ami = "var.ami_value"
    instance_type = "var.instance_type_value"
    subnet_id = "var.subnet_id_value"
    key_name = "var.key_name_value"
  
}

resource "s3" "bucket" {
  
}