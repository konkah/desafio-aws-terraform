# availability zone A
data "aws_availability_zone" "desafio_AWS_a" {
  name = "us-east-1a"
}

# nat gateway A
resource "aws_eip" "desafio_AWS_a" {
  tags = var.tags
}

resource "aws_nat_gateway" "desafio_AWS_a" {
  allocation_id = aws_eip.desafio_AWS_a.id
  subnet_id     = aws_subnet.desafio_AWS_a_public.id

  tags = var.tags
}

# public subnet A public
resource "aws_subnet" "desafio_AWS_a_public" {
  vpc_id     = aws_vpc.desafio_AWS.id
  cidr_block = "10.0.0.0/24"
  availability_zone = data.aws_availability_zone.desafio_AWS_a.name

  tags = var.tags
}

data "aws_ami" "bastion_a" {
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
  ami           = data.aws_ami.bastion_a.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.desafio_AWS_a_public.id

  tags = {
    Name = "desafio_AWS_bastion_a"
  }
}

# private subnet A APP
resource "aws_subnet" "desafio_AWS_a_app" {
  vpc_id     = aws_vpc.desafio_AWS.id
  cidr_block = "10.0.4.0/24"
  availability_zone = data.aws_availability_zone.desafio_AWS_a.name

  tags = var.tags
}

# private subnet A DB
resource "aws_subnet" "desafio_AWS_a_db" {
  vpc_id     = aws_vpc.desafio_AWS.id
  cidr_block = "10.0.6.0/24"
  availability_zone = data.aws_availability_zone.desafio_AWS_a.name

  tags = var.tags
}