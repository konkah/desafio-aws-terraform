resource "aws_vpc" "desafio_AWS" {
  cidr_block           = "10.0.0.0/21"
  enable_dns_hostnames = true

  tags = var.tags
}

#igw
resource "aws_internet_gateway" "desafio_AWS" {
  vpc_id = aws_vpc.desafio_AWS.id

  tags = var.tags
}

# nat gateway A
resource "aws_eip" "desafio_AWS_a" {
  vpc  = true

  depends_on = [
    aws_internet_gateway.desafio_AWS
  ]

  tags = var.tags
}

resource "aws_nat_gateway" "desafio_AWS_a" {
  allocation_id = aws_eip.desafio_AWS_a.id
  subnet_id     = aws_subnet.desafio_AWS_a_public.id

  depends_on = [
    aws_internet_gateway.desafio_AWS
  ]

  tags = var.tags
}

# nat gateway C
resource "aws_eip" "desafio_AWS_c" {
  vpc  = true

  depends_on = [
    aws_internet_gateway.desafio_AWS
  ]

  tags = var.tags
}

resource "aws_nat_gateway" "desafio_AWS_c" {
  allocation_id = aws_eip.desafio_AWS_c.id
  subnet_id     = aws_subnet.desafio_AWS_c_public.id

  depends_on = [
    aws_internet_gateway.desafio_AWS
  ]

  tags = var.tags
}