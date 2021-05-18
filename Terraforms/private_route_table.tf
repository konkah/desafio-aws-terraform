# private route table
resource "aws_route_table" "desafio_AWS_private" {
  vpc_id = aws_vpc.desafio_AWS.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.desafio_AWS_clientes.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "desafio_AWS_private_clientes_app" {
  subnet_id      = aws_subnet.desafio_AWS_clientes_app.id
  route_table_id = aws_route_table.desafio_AWS_private.id
}

resource "aws_route_table_association" "desafio_AWS_private_clientes_db" {
  subnet_id      = aws_subnet.desafio_AWS_clientes_db.id
  route_table_id = aws_route_table.desafio_AWS_private.id
}

resource "aws_route_table_association" "desafio_AWS_private_produtos_app" {
  subnet_id      = aws_subnet.desafio_AWS_produtos_app.id
  route_table_id = aws_route_table.desafio_AWS_private.id
}

resource "aws_route_table_association" "desafio_AWS_private_produtos_db" {
  subnet_id      = aws_subnet.desafio_AWS_produtos_db.id
  route_table_id = aws_route_table.desafio_AWS_private.id
}