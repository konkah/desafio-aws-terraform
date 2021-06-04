use aws_rds_clientes;

CREATE TABLE django_migrations (
  id int NOT NULL AUTO_INCREMENT,
  app varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  applied datetime(6) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE django_session (
  session_key varchar(40) NOT NULL,
  session_data longtext NOT NULL,
  expire_date datetime(6) NOT NULL,
  PRIMARY KEY (session_key),
  KEY django_session_expire_date (expire_date)
);

CREATE TABLE django_content_type (
  id int NOT NULL AUTO_INCREMENT,
  app_label varchar(100) NOT NULL,
  model varchar(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY django_content_type_app_label_model (app_label)
);

CREATE TABLE auth_user (
  id int NOT NULL AUTO_INCREMENT,
  password varchar(128) NOT NULL,
  last_login datetime(6) DEFAULT NULL,
  is_superuser tinyint(1) NOT NULL,
  username varchar(150) NOT NULL,
  first_name varchar(150) NOT NULL,
  last_name varchar(150) NOT NULL,
  email varchar(254) NOT NULL,
  is_staff tinyint(1) NOT NULL,
  is_active tinyint(1) NOT NULL,
  date_joined datetime(6) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY username (username)
);

CREATE TABLE django_admin_log (
  id int NOT NULL AUTO_INCREMENT,
  action_time datetime(6) NOT NULL,
  object_id longtext,
  object_repr varchar(200) NOT NULL,
  action_flag smallint unsigned NOT NULL,
  change_message longtext NOT NULL,
  content_type_id int DEFAULT NULL,
  user_id int NOT NULL,
  PRIMARY KEY (id),
  KEY django_admin_log_content_type_id_fk_django_co (content_type_id),
  KEY django_admin_log_user_id_fk_auth_user_id (user_id),
  CONSTRAINT django_admin_log_content_type_id_fk_django_co
    FOREIGN KEY (content_type_id)
    REFERENCES django_content_type (id),
  CONSTRAINT django_admin_log_user_id_fk_auth_user_id
    FOREIGN KEY (user_id)
    REFERENCES auth_user (id),
  CONSTRAINT django_admin_log_chk_1
    CHECK ((action_flag >= 0))
);

CREATE TABLE auth_group (
  id int NOT NULL AUTO_INCREMENT,
  name varchar(150) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY name (name)
);

CREATE TABLE auth_permission (
  id int NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  content_type_id int NOT NULL,
  codename varchar(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY auth_permission_content_type_id_codename (content_type_id),
  CONSTRAINT auth_permission_content_type_id_fk_django_co
    FOREIGN KEY (content_type_id)
    REFERENCES django_content_type (id)
);

CREATE TABLE auth_group_permissions (
  id int NOT NULL AUTO_INCREMENT,
  group_id int NOT NULL,
  permission_id int NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY auth_group_permissions_group_id_permission_id (group_id, permission_id),
  CONSTRAINT auth_group_permissio_permission_id_fk_auth_perm
    FOREIGN KEY (permission_id)
    REFERENCES auth_permission (id),
  CONSTRAINT auth_group_permissions_group_id_fk_auth_group_id
    FOREIGN KEY (group_id)
    REFERENCES auth_group (id)
);

CREATE TABLE auth_user_groups (
  id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  group_id int NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY auth_user_groups_user_id_group_id (user_id, group_id),
  CONSTRAINT auth_user_groups_group_id_fk_auth_group_id
    FOREIGN KEY (group_id)
    REFERENCES auth_group (id),
  CONSTRAINT auth_user_groups_user_id_fk_auth_user_id
    FOREIGN KEY (user_id)
    REFERENCES auth_user (id)
);

CREATE TABLE auth_user_user_permissions (
  id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  permission_id int NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY auth_user_user_permissions_user_id_permission_id (user_id, permission_id),
  CONSTRAINT auth_user_user_permi_permission_id_fk_auth_perm
    FOREIGN KEY (permission_id)
    REFERENCES auth_permission (id),
  CONSTRAINT auth_user_user_permissions_user_id_fk_auth_user_id
    FOREIGN KEY (user_id)
    REFERENCES auth_user (id)
);

CREATE TABLE api_tbl_clientes (
  id int NOT NULL AUTO_INCREMENT,
  nome_completo_cliente varchar(200) NOT NULL,
  cpf varchar(15) NOT NULL,
  email varchar(200) NOT NULL,
  data_nascimento date NOT NULL,
  numero_telefone varchar(15) NOT NULL,
  deletado tinyint(1) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE api_tbl_enderecos (
  id int NOT NULL AUTO_INCREMENT,
  rua varchar(200) NOT NULL,
  numero varchar(10) NOT NULL,
  complemento varchar(50) NOT NULL,
  cep varchar(9) NOT NULL,
  cidade varchar(200) NOT NULL,
  estado varchar(200) NOT NULL,
  pais varchar(200) NOT NULL,
  cliente_id int NOT NULL,
  deletado tinyint(1) NOT NULL,
  PRIMARY KEY (id)
);

insert into auth_user
        (password, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined)
    values
        ('pbkdf2_sha256$216000$jX727gAU9ceo$YRJ1NR8K0JT7IX1j8VGBJYGLcL/ydrXp5+Vd2s9idTw=', 1, 'admin', '', '', 'karlos.braga@inmetrics.com.br', 1, 1, now());
