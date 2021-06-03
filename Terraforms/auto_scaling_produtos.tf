resource "aws_launch_template" "desafio_AWS_produtos" {
  name_prefix   = "app_produtos"
  image_id      = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "desafio_AWS_produtos"
    }
  }

  vpc_security_group_ids = [ 
    aws_security_group.desafio_AWS_produtos.id 
  ]

  tags = var.tags
}

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
}

# look at auto_scaling produtos
resource "aws_lb_target_group" "desafio_AWS_produtos" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.desafio_AWS.id

  tags = var.tags
}

resource "aws_security_group" "desafio_AWS_produtos" {
  description = "API - Produtos"
  vpc_id = aws_vpc.desafio_AWS.id
  
  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
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