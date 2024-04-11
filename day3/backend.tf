terraform {
  backend "s3" {
    bucket = "bitun-s3-demo"
    key    = "bitun/terraform.tf"
    region = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}
