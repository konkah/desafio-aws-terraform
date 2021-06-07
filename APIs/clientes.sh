#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y

sudo mkdir /var/www
sudo chmod 777 /var/www
curl -s -L -o /var/www/project.zip https://github.com/konkah/desafio-api-clientes/archive/refs/heads/main.zip
cd /var/www/

sudo apt install -y unzip
unzip project.zip
mv desafio-api-clientes-main/api_clientes/* /var/www
rm -r desafio-api-clientes-main
rm project.zip

sudo chmod 777 api_clientes/address.py
echo "CLIENTES_RDS = 'mysql-api-clientes.cxycaymkd24m.us-east-1.rds.amazonaws.com'" > api_clientes/address.py

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
