output "vpc_id" {
  value = aws_default_vpc.default.id
}

output "public_subnet_ids" {
  value = aws_default_subnet.default[*].id
}

output "sg" {
  value = {
    web = aws_security_group.web_sg.id
    db = aws_security_group.db_sg.id
  }
}