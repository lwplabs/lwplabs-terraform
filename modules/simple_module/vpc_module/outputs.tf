output "vpc_id" {
    value = aws_vpc.this.id
}

output "public_subnet_id" {
    value = toset(aws_subnet.public[*].id)
}

output "private_subnet_id" {
    value = toset(aws_subnet.private[*].id)
}