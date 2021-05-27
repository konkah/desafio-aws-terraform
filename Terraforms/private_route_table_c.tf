# private route table
resource "aws_route_table" "desafio_AWS_private_c" {
  vpc_id = aws_vpc.desafio_AWS.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.desafio_AWS_a.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "desafio_AWS_private_c_app" {
  subnet_id      = aws_subnet.desafio_AWS_c_app.id
  route_table_id = aws_route_table.desafio_AWS_private_c.id
}

resource "aws_route_table_association" "desafio_AWS_private_c_db" {
  subnet_id      = aws_subnet.desafio_AWS_c_db.id
  route_table_id = aws_route_table.desafio_AWS_private_c.id
}