resource "aws_instance" "fiap-hmv-ec2" {
  count         = var.ec2_count
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  key_name      = var.ec2_key_name

  tags = {
    Projeto = var.projeto
    Name    = "${var.ec2_name}-${count.index}"
  }
}