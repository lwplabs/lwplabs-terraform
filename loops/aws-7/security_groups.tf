resource "aws_security_group" "allow-ssh" {
  vpc_id      = aws_vpc.prod.id
  name = "allow-ssh"
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web-secgroup" {
  vpc_id      = aws_vpc.prod.id
  name = "web-server-sec-group"
  dynamic "ingress" {
    for_each = var.inbound_ports
    content {
    protocol = "tcp"
    from_port = ingress.value
    to_port = ingress.value
    cidr_blocks = ["0.0.0.0/0"]
  }
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "webserver-secgroup"
  }
}