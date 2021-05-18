# availability zone A
data "aws_availability_zone" "desafio_AWS_clientes" {
  name = "us-east-1a"
}

# nat gateway A
resource "aws_eip" "desafio_AWS_clientes" {
  tags = var.tags
}

resource "aws_nat_gateway" "desafio_AWS_clientes" {
  allocation_id = aws_eip.desafio_AWS_clientes.id
  subnet_id     = aws_subnet.desafio_AWS_clientes_public.id

  tags = var.tags
}

# public subnet A public
resource "aws_subnet" "desafio_AWS_clientes_public" {
  vpc_id     = aws_vpc.desafio_AWS.id
  cidr_block = "10.0.0.0/24"
  availability_zone = data.aws_availability_zone.desafio_AWS_clientes.name

  tags = var.tags
}

# public subnet A APP
resource "aws_subnet" "desafio_AWS_clientes_app" {
  vpc_id     = aws_vpc.desafio_AWS.id
  cidr_block = "10.0.4.0/24"
  availability_zone = data.aws_availability_zone.desafio_AWS_clientes.name

  tags = var.tags
}

# public subnet A DB
resource "aws_subnet" "desafio_AWS_clientes_db" {
  vpc_id     = aws_vpc.desafio_AWS.id
  cidr_block = "10.0.6.0/24"
  availability_zone = data.aws_availability_zone.desafio_AWS_clientes.name

  tags = var.tags
}