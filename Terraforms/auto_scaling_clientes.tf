resource "aws_launch_template""desafio_AWS_clientes" {
    name_prefix = "app_clientes"
    image_id = "ami-0d5eff06f840b45e9"
    instance_type = "t2.micro"

    tag_specifications {
      resource_type = "instance"

      tags = {
        Name = "desafio_AWS_clientes"
      }
    }

    tags = var.tags
}

resource "aws_autoscaling_group" "desafio_AWS_clientes" {
    min_size                      = 2
    desired_capacity              = 2
    max_size                      = 4
    vpc_zone_identifier           = [
                                    aws_subnet.desafio_AWS_a_app.id, 
                                    aws_subnet.desafio_AWS_c_app.id
                                    ]

    launch_template {
      id=aws_launch_template.desafio_AWS_clientes.id
      version = "$Latest"
    }
}