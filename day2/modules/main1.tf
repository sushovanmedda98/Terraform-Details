provider "aws" {
    region = "us-east-1"
  
}

module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami-value ="ami-080e1f13689e07408"
    instance_type_value ="t2.micro"
    subnet_id_value ="subnet-0637d5e50e8ad7350"
    key_name_value ="bitun"
        
        
    
  
}