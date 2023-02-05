provider "aws" {
  region = local.region
}

locals {
  name   = "digital"
  region = "us-east-1"

  user_data = <<-EOT
  #!/bin/bash
  yum update -y
  yum install httpd -y
  EOT

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = local.name

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = element(module.vpc.private_subnets, 0)
  associate_public_ip_address = true
  user_data_base64       = base64encode(local.user_data)

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


################################################################################
# Supporting Resources
################################################################################

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = "10.99.0.0/18"

  enable_nat_gateway  = true
  single_nat_gateway  = true

  azs              = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets   = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
  private_subnets  = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]

  tags = local.tags
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = "Security group for example usage with EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp","http-8080-tcp","https-443-tcp","ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = local.tags
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name           = "user1"
  create_private_key = true
}

output "private_key" {
    value = module.key_pair.private_key_pem
    sensitive = true
  
}

output "public_ip" {

    value = module.ec2_instance.public_ip
  
}