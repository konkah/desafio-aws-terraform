use aws_rds_clientes;

create table api_tbl_clientes (
    ID int auto_increment primary key,
    nome_completo_cliente varchar(200),
    cpf varchar(15),
    email varchar(200),
    data_nascimento date,
    numero_telefone varchar(15),
    deletado tinyint
);

create table api_tbl_enderecos (
    ID int auto_increment primary key,
    rua varchar(200),
    numero varchar(10),
    complemento varchar(50),
    cep varchar(9),
    cidade varchar(200),
    estado varchar(200),
    pais varchar(200),
    cliente_id int,
    deletado tinyint,
    constraint fk_enderecos_clientes
        foreign key (cliente_id)
        references api_tbl_clientes (ID)
);
