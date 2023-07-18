data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [var.vpc_sg.web]
  associate_public_ip_address = true

  user_data = file("${path.module}/userdata.tpl")

  user_data_replace_on_change = true
  tags = {
    Name = "${var.name}-ec2-webserver"
  }
}
