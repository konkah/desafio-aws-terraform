resource "aws_db_instance" "desafio_AWS_produtos" {
  allocated_storage    = 10
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  name                 = "aws_rds_produtos"
  username             = "user"
  password             = "PassworD"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.desafio_AWS_produtos.name

  tags = var.tags
}

resource "aws_db_subnet_group" "desafio_AWS_produtos" {
  name = "produtos_group"
  subnet_ids = [
    aws_subnet.desafio_AWS_c_db.id,
    aws_subnet.desafio_AWS_a_db.id
  ]

  tags = var.tags
}