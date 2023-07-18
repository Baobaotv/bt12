data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  az_names = slice(data.aws_availability_zones.available.names, 0, 2)
  az_cnt   = 2
}

resource "aws_default_vpc" "default" {

}

resource "aws_default_subnet" "default" {
  count             = local.az_cnt
  availability_zone = local.az_names[count.index]

  tags = {
    Name = "DB subnet for ${local.az_names[count.index]}"
  }
}

resource "aws_security_group" "web_sg" {
  name   = "${var.name}-web-sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow HTTP"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow HTTP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-web-http"
  }
}

resource "aws_security_group" "db_sg" {
  name   = "${var.name}-db-sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow SSH"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-db-sg"
  }
}
