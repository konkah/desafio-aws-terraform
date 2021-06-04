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

sudo apt install -y python3.8
sudo apt install python3-pip -y
sudo apt install python3-dev -y 
sudo apt install libmysqlclient-dev -y

python3 -m pip install -U pip
python3 -m pip install -U setuptools
python3 -m pip install -U wheel
python3 -m pip install -r requirements.txt

nohup python3 manage.py runserver 0.0.0.0:80
