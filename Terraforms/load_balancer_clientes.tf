resource "aws_lb" "desafio_AWS_clientes" {
    subnets            = [ 
                           aws_subnet.desafio_AWS_a_app.id,
                           aws_subnet.desafio_AWS_c_app.id
                         ]

    tags = var.tags
}