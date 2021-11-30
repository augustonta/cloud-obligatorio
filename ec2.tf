resource "aws_instance" "linux-gest" {
  ami                    = var.amitype
  instance_type          = var.tipoinstancia
  subnet_id              = aws_subnet.subnet_public_1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = "augusto-martin"
}