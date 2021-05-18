resource "aws_launch_template""desafio_AWS_produtos" {
    name_prefix = "app_produtos"
    image_id = "ami-0d5eff06f840b45e9"
    instance_type = "t2.micro"

    tags = var.tags
}

resource "aws_autoscaling_group" "desafio_AWS_produtos" {
    min_size                      = 2
    desired_capacity              = 2
    max_size                      = 4
    vpc_zone_identifier           = [aws_subnet.desafio_AWS_produtos_app.id]

    launch_template {
      id=aws_launch_template.desafio_AWS_produtos
      version = "$Latest"
    }

    load_balancers = [ aws_lb.desafio_AWS_produtos.id ]
}

resource "aws_lb" "desafio_AWS_produtos" {
    tags = var.tags
}