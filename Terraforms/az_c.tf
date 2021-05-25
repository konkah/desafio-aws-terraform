# availability zone C
data "aws_availability_zone" "desafio_AWS_c" {
  name = "us-east-1c"
}

# nat gateway C
resource "aws_eip" "desafio_AWS_c" {
  tags = var.tags
}

resource "aws_nat_gateway" "desafio_AWS_c" {
  allocation_id = aws_eip.desafio_AWS_c.id
  subnet_id     = aws_subnet.desafio_AWS_c_public.id

  tags = var.tags
}

# public subnet C public
resource "aws_subnet" "desafio_AWS_c_public" {
  vpc_id     = aws_vpc.desafio_AWS.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zone.desafio_AWS_c.name

  tags = var.tags
}

# private subnet C APP
resource "aws_subnet" "desafio_AWS_c_app" {
  vpc_id     = aws_vpc.desafio_AWS.id
  cidr_block = "10.0.5.0/24"
  availability_zone = data.aws_availability_zone.desafio_AWS_c.name

  tags = var.tags
}

# private subnet C DB
resource "aws_subnet" "desafio_AWS_c_db" {
  vpc_id     = aws_vpc.desafio_AWS.id
  cidr_block = "10.0.7.0/24"
  availability_zone = data.aws_availability_zone.desafio_AWS_c.name

  tags = var.tags
}

