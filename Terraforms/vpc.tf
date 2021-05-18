resource "aws_vpc" "desafio_AWS" {
  cidr_block = "10.0.0.0/21"
  enable_dns_hostnames = true
  
  tags = var.tags
}

#igw
resource "aws_internet_gateway" "desafio_AWS" {
  vpc_id = aws_vpc.desafio_AWS.id

  tags = var.tags
}