resource "aws_lb" "desafio_AWS" {
  subnets = [
    aws_subnet.desafio_AWS_a_app.id,
    aws_subnet.desafio_AWS_c_app.id
  ]

  name               = "kd-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.desafio_AWS_lb.id]

  tags = var.tags
}

output "CLIENTES_API" {
  value = aws_lb.desafio_AWS.dns_name
}

resource "aws_lb_listener" "desafio_AWS" {
  port     = 80
  protocol = "HTTP"

  load_balancer_arn = aws_lb.desafio_AWS.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "desafio_AWS_clientes" {
  listener_arn = aws_lb_listener.desafio_AWS.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.desafio_AWS_clientes.arn
  }

  condition {
    path_pattern {
      values = [
        "/clientes_api/*",
        "/enderecos_api/*"
      ]
    }
  }
}

resource "aws_lb_listener_rule" "desafio_AWS_produtos" {
  listener_arn = aws_lb_listener.desafio_AWS.arn
  priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.desafio_AWS_produtos.arn
  }

  condition {
    path_pattern {
      values = [
        "/produtos_api/*",
        "/inventarios_api/"
      ]
    }
  }
}

resource "aws_security_group" "desafio_AWS_lb" {
  description = "Load Balancer"
  vpc_id = aws_vpc.desafio_AWS.id
  
  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HTTP_AWS_lb"
  }

}