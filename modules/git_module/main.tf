module "vpc" {
  source = "git::https://github.com/lwplabs/lwplabs-modules.git//vpc_module"


  name = "mysuite"
  env  = "dev"

  cidr = "172.20.0.0/21"

  private_subnets = ["172.20.0.0/25", "172.20.0.128/25", "172.20.1.0/25"]
  public_subnets  = ["172.20.4.0/25", "172.20.4.128/25", "172.20.5.0/25"]
  
}


resource "aws_instance" "web" {
  ami           = var.AMIS[var.REGION]
  instance_type = "t2.micro"
  subnet_id = module.vpc.public_subnet_id[0]
  vpc_security_group_ids = [aws_security_group.allow-ssh.id,aws_security_group.web-secgroup.id]
  key_name = aws_key_pair.mykeypair.key_name
  user_data = local.template_file_int
}


locals {
   template_file_int  = templatefile("./install.tpl", {})
}


output "public" {
  value = aws_instance.web.public_ip
  
}