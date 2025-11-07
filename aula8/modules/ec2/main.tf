# Instância EC2 em sub-rede privada (acesso via bastion/SSM)
resource "aws_security_group" "app_sg" {
  name        = "${var.env}-app-sg"
  description = "SG da aplicação"
  vpc_id      = data.aws_vpc.selected.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "${var.env}-app-sg" }
}

data "aws_vpc" "selected" {
  id = split("/", var.subnet_id)[2] != "" ? "" : null # placeholder (não usado)
}

resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  tags = { Name = "${var.env}-app" }
}
