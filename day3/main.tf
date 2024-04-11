provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "terraform" {
    ami = "ami-0c101f26f147fa7fd"
    instance_type = "t2.micro"
    key_name = "*****"
    subnet_id = "subnet-06a41824b8d0bc464"
  
}


resource "aws_s3_bucket" "bitun_s3" {
    bucket = "bitun-s3-demo"
  
}


resource "aws_dynamodb_table" "terraform_lock" {
    name = "terraform-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"


    attribute {
      name = "LockID"
      type = "S"
    }
  
}