#!/bin/bash
AZUL='\e[01;34m'
AMARELO='\e[01;33m'
NULL='\e[00m'

banner() {
#Banner da Tool
echo -e "${AZUL}"
echo " ██▓ ██▓███   ██▓     ▒█████   ▄████▄   ▄▄▄     ▄▄▄█████▓ ██▓ ▒█████   ███▄    █ ";
echo "▓██▒▓██░  ██▒▓██▒    ▒██▒  ██▒▒██▀ ▀█  ▒████▄   ▓  ██▒ ▓▒▓██▒▒██▒  ██▒ ██ ▀█   █ ";
echo "▒██▒▓██░ ██▓▒▒██░    ▒██░  ██▒▒▓█    ▄ ▒██  ▀█▄ ▒ ▓██░ ▒░▒██▒▒██░  ██▒▓██  ▀█ ██▒";
echo "░██░▒██▄█▓▒ ▒▒██░    ▒██   ██░▒▓▓▄ ▄██▒░██▄▄▄▄██░ ▓██▓ ░ ░██░▒██   ██░▓██▒  ▐▌██▒";
echo "░██░▒██▒ ░  ░░██████▒░ ████▓▒░▒ ▓███▀ ░ ▓█   ▓██▒ ▒██▒ ░ ░██░░ ████▓▒░▒██░   ▓██░";
echo "░▓  ▒▓▒░ ░  ░░ ▒░▓  ░░ ▒░▒░▒░ ░ ░▒ ▒  ░ ▒▒   ▓▒█░ ▒ ░░   ░▓  ░ ▒░▒░▒░ ░ ▒░   ▒ ▒ ";
echo " ▒ ░░▒ ░     ░ ░ ▒  ░  ░ ▒ ▒░   ░  ▒     ▒   ▒▒ ░   ░     ▒ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░";
echo " ▒ ░░░         ░ ░   ░ ░ ░ ▒  ░          ░   ▒    ░       ▒ ░░ ░ ░ ▒     ░   ░ ░ ";
echo " ░               ░  ░    ░ ░  ░ ░            ░  ░         ░      ░ ░           ░ ";
echo "                              ░                                                  ";
echo "================================== By Kl3gari ==================================="
echo -e "${NULL}"
}

testajq() {
#Teste para ver se a tool jq existe no sistema do usuário
  if  [[ ! -e /usr/bin/jq ]]
  then
    echo ""
    echo "O jq não está instalado!"
    echo ""
    echo "Alguns maneiras de instalar:"
    echo "## sudo apt-get install jq"
    echo "## sudo dnf install jq"
    echo "## sudo zypper install jq "
    echo "## sudo pacman -S jq"
    exit 1
  fi

}

testargumento(){
#Teste de existência da variável
ip=$1
  if [[ -z $ip ]]; then
    echo -e "${AMARELO}Modo de Uso: ./iplocation IP ${NULL}"
    echo ""
    exit 1
  fi
}

resultado(){
curl -s "http://api.ipstack.com/$ip?access_key=4bbe162b2a7ab33a482badc535aec334&format=1&language=pt-br" -o /tmp/Iplocation.json
  echo ''
  echo -e "${AMARELO}Ip:${NULL} $(jq '.ip' /tmp/Iplocation.json)" | tr -d '\"'
  echo -e "${AMARELO}Tipo:${NULL} $(jq '.type' /tmp/Iplocation.json)" | tr -d '\"'
  echo -e "${AMARELO}Continente:${NULL} $(jq '.continent_name' /tmp/Iplocation.json)" | tr -d '\"'
  echo -e "${AMARELO}Código do País:${NULL} $(jq '.country_code' /tmp/Iplocation.json)" | tr -d '\"'
  echo -e "${AMARELO}País:${NULL} $(jq '.country_name' /tmp/Iplocation.json)" | tr -d '\"'
  echo -e "${AMARELO}Código da região:${NULL} $(jq '.region_code' /tmp/Iplocation.json)" | tr -d '\"'
  echo -e "${AMARELO}Região:${NULL} $(jq '.region_name' /tmp/Iplocation.json)" | tr -d '\"'
  echo -e "${AMARELO}Cidade:${NULL} $(jq '.city' /tmp/Iplocation.json)" | tr -d '\"'
  echo -e "${AMARELO}atitude:${NULL} $(jq '.latitude' /tmp/Iplocation.json)"
  echo -e "${AMARELO}Longitude:${NULL} $(jq '.longitude' /tmp/Iplocation.json)"
  echo ''
rm /tmp/Iplocation.json
}

main(){
  banner
  testajq
  testargumento $1
  resultado
}

main "$@"
