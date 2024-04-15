provider "aws" {
    region = "us-east-1"
  
}

variable "cidr" {
    default = "10.0.0.0/16"
  
}

resource "aws_key_pair" "bitum" {
    key_name = "bitun"
    public_key = file("~/.ssh/id_rsa.pub")
  
}

resource "aws_vpc" "myvpcname" {
   cidr_block = var.cidr
}

resource "aws_subnet" "mysubnet" {
  vpc_id = aws_vpc.myvpcname.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.myvpcname.id
}

resource "aws_route_table" "myroutetable" {
    vpc_id = aws_vpc.myvpcname.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mygateway.id
    }
}
  
resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.myroutetable.id
}

resource "aws_security_group" "SG" {
    name = "web"
    vpc_id = aws_vpc.myvpcname.id


    ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
  
}

resource "aws_instance" "server" {
  ami                    = "ami-0261755bbcb8c4a84"
  instance_type          = "t2.micro"
  key_name      = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("~/.ssh/id_rsa")  # Replace with the path to your private key
    host        = self.public_ip
  }

 # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }


  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }
}
