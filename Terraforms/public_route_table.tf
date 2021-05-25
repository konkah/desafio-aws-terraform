# public route table
resource "aws_route_table" "desafio_AWS_public" {
  vpc_id = aws_vpc.desafio_AWS.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.desafio_AWS.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "desafio_AWS_public_a" {
  subnet_id      = aws_subnet.desafio_AWS_a_public.id
  route_table_id = aws_route_table.desafio_AWS_public.id
}

resource "aws_route_table_association" "desafio_AWS_public_c" {
  subnet_id      = aws_subnet.desafio_AWS_c_public.id
  route_table_id = aws_route_table.desafio_AWS_public.id
}