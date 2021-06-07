#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y

sudo mkdir /var/www
sudo chmod 777 /var/www
curl -s -L -o /var/www/project.zip https://github.com/konkah/desafio-api-produtos/archive/refs/heads/main.zip
cd /var/www/

sudo apt install -y unzip
unzip project.zip
mv desafio-api-produtos-main/api_produtos/* /var/www
rm -r desafio-api-produtos-main
rm project.zip

sudo chmod 777 api_produtos/address.py
echo "PRODUTOS_RDS = 'mysql-api-produtos.cxycaymkd24m.us-east-1.rds.amazonaws.com'" > api_produtos/address.py
echo "CLIENTES_API = 'kd-load-balancer-1966111480.us-east-1.elb.amazonaws.com'" >> api_produtos/address.py

sudo apt install -y python3.8
sudo apt update
sudo apt upgrade -y
sudo apt install python3-pip -y
sudo apt install python3-dev -y 
sudo apt install libmysqlclient-dev -y

sudo python3 -m pip install -U pip
sudo python3 -m pip install -U setuptools
sudo python3 -m pip install -U wheel
sudo python3 -m pip install -r requirements.txt

nohup sudo python3 manage.py runserver

echo "finished" > status.log
