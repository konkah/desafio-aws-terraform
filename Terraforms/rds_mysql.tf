resource "aws_db_instance" "desafio_AWS_clientes" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"

  name                 = "aws_rds_clientes"
  username             = "user"
  password             = "PassworD"

  skip_final_snapshot  = true
  multi_az             = true

  identifier           = "mysql-api-clientes"

  db_subnet_group_name = aws_db_subnet_group.desafio_AWS.name

  vpc_security_group_ids = [
    aws_security_group.desafio_AWS_rds.id
  ]

	depends_on = [ 
		aws_security_group.desafio_AWS_rds
	]

  tags = var.tags
}

output "CLIENTES_RDS" {
  value = aws_db_instance.desafio_AWS_clientes.address
}

resource "aws_db_instance" "desafio_AWS_produtos" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"

  name                 = "aws_rds_produtos"
  username             = "user"
  password             = "PassworD"

  skip_final_snapshot  = true
  multi_az             = true

  identifier           = "mysql-api-produtos"

  db_subnet_group_name = aws_db_subnet_group.desafio_AWS.name

  vpc_security_group_ids = [
    aws_security_group.desafio_AWS_rds.id
  ]

	depends_on = [ 
		aws_security_group.desafio_AWS_rds
	]

  tags = var.tags
}

output "PRODUTOS_RDS" {
  value = aws_db_instance.desafio_AWS_produtos.address
}

resource "aws_db_subnet_group" "desafio_AWS" {
  name = "rds_subnet_group"
  subnet_ids = [
    aws_subnet.desafio_AWS_c_db.id,
    aws_subnet.desafio_AWS_a_db.id
  ]

  tags = var.tags
}

resource "aws_security_group" "desafio_AWS_rds" {
  description = "RDS - MySQL"
  vpc_id = aws_vpc.desafio_AWS.id
  
  ingress {
    description = "MySQL Port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [
      "10.0.0.0/24",
      "10.0.1.0/24",
      "10.0.4.0/24",
      "10.0.5.0/24",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysql_AWS_rds"
  }

}