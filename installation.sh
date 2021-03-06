#!/bin/bash

usage(){

cat << EOF
OPTIONS:
   -h      Show this message
   -d      Install docker
   -c      Install docker compose
   -s      Start
EOF

}

installDockerCompose(){
  sudo apt-get update
  curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
}

installDocker(){
  apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
     "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt-get update
  apt-get install docker-ce docker-ce-cli containerd.io
}


start(){
  docker-compose up
}


if [ "$#" -eq 0 ]
then
  installDocker
  installDockerCompose
  start
else
  while getopts “hdcs” OPTION
  do
    case $OPTION in
      h)
        usage
        exit 1
        ;;
      d)
        installDocker
        ;;
      c)
        installDockerCompose
        ;;
      s)
      	start
      	;;
      ?)
        usage
        exit
        ;;
    esac
  done
fi
