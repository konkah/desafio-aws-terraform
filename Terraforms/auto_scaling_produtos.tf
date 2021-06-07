resource "aws_autoscaling_group" "desafio_AWS_produtos" {
  min_size         = 2
  desired_capacity = 2
  max_size         = 4
  vpc_zone_identifier = [
    aws_subnet.desafio_AWS_c_app.id,
    aws_subnet.desafio_AWS_a_app.id
  ]

  launch_template {
    id      = aws_launch_template.desafio_AWS_produtos.id
    version = "$Latest"
  }

  target_group_arns = [ 
    aws_lb_target_group.desafio_AWS_produtos.arn
  ]

  depends_on = [
    null_resource.address_helper_produtos
  ]
}

resource "aws_lb_target_group" "desafio_AWS_produtos" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.desafio_AWS.id

  tags = var.tags
}

resource "aws_launch_template" "desafio_AWS_produtos" {
  name_prefix   = "app_produtos"
  image_id      = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.bastion_key.key_name

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "desafio_AWS_produtos"
    }
  }

  vpc_security_group_ids = [ 
    aws_security_group.desafio_AWS_produtos.id 
  ]

  user_data = filebase64("../APIs/produtos.sh")

  tags = var.tags
}

resource "null_resource" "address_helper_produtos" {
  depends_on = [
    aws_db_instance.desafio_AWS_clientes,
  ]

  provisioner "local-exec" {
    command = "sed -i \"20c echo \\\"PRODUTOS_RDS = '${aws_db_instance.desafio_AWS_produtos.address}'\\\" > api_produtos/address.py\" ../APIs/produtos.sh"
  }

  provisioner "local-exec" {
    command = "sed -i \"21c echo \\\"CLIENTES_API = '${aws_lb.desafio_AWS.dns_name}'\\\" >> api_produtos/address.py\" ../APIs/produtos.sh"
  }
}

resource "aws_security_group" "desafio_AWS_produtos" {
  description = "API - Produtos"
  vpc_id = aws_vpc.desafio_AWS.id
  
  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      "10.0.0.0/24",
      "10.0.1.0/24",
      "10.0.4.0/24",
      "10.0.5.0/24",
    ]
  }

  ingress {
    description = "Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/23"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HTTP_AWS_autoscaling_produtos"
  }
}