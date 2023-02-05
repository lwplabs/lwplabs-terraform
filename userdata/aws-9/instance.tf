resource "aws_instance" "web" {
  ami           = var.AMIS[var.REGION]
  instance_type = "t2.micro"
  subnet_id = aws_subnet.prod-public[0].id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id,aws_security_group.web-secgroup.id]
  key_name = aws_key_pair.mykeypair.key_name
  user_data = local.template_file_int
}



  # the security group
  #vpc_security_group_ids = [aws_security_group.allow-ssh.id,aws_security_group.web-secgroup.id]

  # the public SSH key
  #key_name = aws_key_pair.mykeypair.key_name
  #user_data = local.template_file_int

#   tags = {
#     Name = "kube-worker"
#     "kubernetes.io/cluster/kubeadm" = "owned"
#     Role = "worker"
#     type = "terraform"
#     created = "terraform"
#   }
# }


locals {
   template_file_int  = templatefile("./install.tpl", {})
}


output "public" {
  value = aws_instance.web.public_ip
  
}