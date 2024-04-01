provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "terraform" {
    ami = "ami-0c101f26f147fa7fd"
    instance_type = "t2.micro"
    key_name = "*****"
    subnet_id = "subnet-06a41824b8d0bc464"
  
}
