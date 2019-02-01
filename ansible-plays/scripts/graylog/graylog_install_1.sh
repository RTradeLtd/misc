#! /bin/bash
sudo apt update -y
sudo apt upgrade -y
# install needed tools
sudo apt install apt-transport-https uuid-runtime pwgen openjdk-8-jre-headless
# install elasticsearch gpg key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
# install elastic search 5.x apt repo
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
# update repos
sudo apt update -y
sudo apt upgrade -y
# install elastic search
sudo apt install elasticsearch