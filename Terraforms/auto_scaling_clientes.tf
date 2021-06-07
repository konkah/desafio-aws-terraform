resource "aws_autoscaling_group" "desafio_AWS_clientes" {
  min_size         = 2
  desired_capacity = 2
  max_size         = 4
  vpc_zone_identifier = [
    aws_subnet.desafio_AWS_a_app.id,
    aws_subnet.desafio_AWS_c_app.id
  ]

  target_group_arns = [ 
    aws_lb_target_group.desafio_AWS_clientes.arn
  ]

  launch_template {
    id      = aws_launch_template.desafio_AWS_clientes.id
    version = "$Latest"
  }

  depends_on = [
    null_resource.address_helper_clientes
  ]
}

resource "aws_lb_target_group" "desafio_AWS_clientes" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.desafio_AWS.id

  tags = var.tags
}

resource "aws_launch_template" "desafio_AWS_clientes" {
  name_prefix   = "app_clientes"
  image_id      = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.bastion_key.key_name

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "desafio_AWS_clientes"
    }
  }

  vpc_security_group_ids = [ 
    aws_security_group.desafio_AWS_clientes.id 
  ]

  user_data = filebase64("../APIs/clientes.sh")

  tags = var.tags
}

resource "null_resource" "address_helper_clientes" {
  depends_on = [
    aws_db_instance.desafio_AWS_clientes,
  ]

  provisioner "local-exec" {
    command = "sed -i \"20c echo \\\"CLIENTES_RDS = '${aws_db_instance.desafio_AWS_clientes.address}'\\\" > api_clientes/address.py\" ../APIs/clientes.sh"
  }
}

resource "aws_security_group" "desafio_AWS_clientes" {
  description = "API - Clientes"
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
    Name = "HTTP_AWS_autoscaling_clientes"
  }
}
