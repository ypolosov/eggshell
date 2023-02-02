
output "default_instance_public_ip" {
  value = aws_instance.default.public_ip
}

output "subnet_id" {
  value = aws_subnet.default_a.id
}

output "last_ubuntu" {
  value = data.aws_ami.last_ubuntu.id
}
