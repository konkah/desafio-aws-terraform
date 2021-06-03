data "aws_ami" "bastion" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "desafio_AWS_a" {
  ami                         = data.aws_ami.bastion.id
  key_name                    = aws_key_pair.bastion_key.key_name
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.desafio_AWS_a_public.id
  security_groups             = [aws_security_group.allow_ssh_bastion.id]
  associate_public_ip_address = true

  tags = {
    Name = "desafio_AWS_bastion_a"
  }
}

resource "aws_instance" "desafio_AWS_c" {
  ami                         = data.aws_ami.bastion.id
  key_name                    = aws_key_pair.bastion_key.key_name
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.desafio_AWS_c_public.id
  security_groups             = [aws_security_group.allow_ssh_bastion.id]
  associate_public_ip_address = true

  tags = {
    Name = "desafio_AWS_bastion_c"
  }
}

resource "aws_security_group" "allow_ssh_bastion" {
  description = "Allow SSH Bastion Host"
  vpc_id      = aws_vpc.desafio_AWS.id

  ingress {
    description = "SSH Port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["201.82.34.44/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSH_AWS_bastion"
  }
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion_key_pub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCunkjqDxDDYY8RctcD4SoB3g7xsL/INTI2vNUwIhic6Vb5Gj96s+OOrCrzIJkvl45zgqXDcrtgtDzGr41ZBLP0FTdi0AjvpDJy4H6MH8LltRifuhULy9ysS6ZVmB2hGjJM3jppxnG/stQ8pa+5uDeBLbWb3FgiFZc6wzUdfiI4hdLEWzHwKHydZ/eS70vFqRqTA1Bnfpi5K989T3BGK+61fD700dHxc6ENau4609TKCAtxyG6zA1vw2yDC2F1sZVOdBY5it5TtM6eY8k5aMXuQ6gshtzd35UHxEv/RNbyQZ+CyAD8Wywwp1xDeGfqCKtt4Wo2TcIFHJI5oamvsBf/c6S/JJ2hzYwALQIcSBySKQxlQzfYH4oLZYWT1HqjQ7BVtSdO7eGCpyXX4KyZa2x9Tws0JqHBGGzgZ0Md1oD1Hokco6dOgOm7e5UgsRJLLduqhW+Oecu8no7BKNzuOB9dy/uE0wRNBVgE4UzJWk34I/ek0QKR4AYjXmNu3IbCgzeSQsslDmXvJPZrKTtjJ1ceCKDR6U6rdcWrMQYEHSWp0BOs5861YP1RXeBuB5Ytmh6GVzSom8Jdndk2unJDhzcIBq41VB3k7d1gRjGQ9hpwSN8uF7NAyoAtph7qpLSnSRUOwj6x8ASEHgPaAj1ziYaJJXptyfJWehDF8FC5g4L9VFw== karlos.braga@inmetrics.com"
}