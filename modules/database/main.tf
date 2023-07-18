resource "aws_db_subnet_group" "db_subnet" {
  name       = "${var.name}-group"
  subnet_ids = var.vpc_public_subnet_ids
}

resource "aws_db_instance" "database" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  multi_az               = false
  identifier             = "${var.name}-db-instance"
  db_name                = "terraform"
  username               = "admin"
  password               = "admin12345"
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [var.vpc_sg.db]
  skip_final_snapshot    = true
}
