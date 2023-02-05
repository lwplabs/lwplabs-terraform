resource "aws_instance" "worker" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  #for_each      = data.aws_subnet_ids.selected.ids
  #iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  subnet_id = aws_subnet.prod-public[0].id
}

  # the security group
  #vpc_security_group_ids = [aws_security_group.allow-ssh.id,aws_security_group.Demo-kube-worker-sg.id,aws_security_group.Demo-kube-mutual-sg.id]

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


# locals {
#    template_file_int  = templatefile("./install_docker_kubectl.tpl", {})
# }