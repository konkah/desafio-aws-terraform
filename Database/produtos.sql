use aws_rds_produtos;

create table tbl_produtos (
    ID int auto_increment primary key,
    nome_produto varchar(200),
    preco_produto double,
    disponivel_produto tinyint,
    deletado tinyint
);

create table tbl_inventarios (
    ID int auto_increment primary key,
    cliente_id int,
    produto_id int,
    deletado tinyint
);
