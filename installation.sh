#!/bin/bash

usage(){

cat << EOF
OPTIONS:
   -h      Show this message
   -d      Install docker
   -c      Install docker compose
   -b      Build local images
EOF

}

getRemote(){
  sudo apt-get update

  sudo apt-get install -y git
  git clone https://github.com/ging/practica_big_data_2019

  cp practica_big_data_2019/resources/download_data.sh Dockerfiles/Mongo/download_data.sh
  cp practica_big_data_2019/resources/import_distances.sh Dockerfiles/Mongo/import_distances.sh
}

installDockerCompose(){}

installDocker(){}

buildImages(){}

if [ "$#" -eq 0 ]
then
  getRemote
else
  while getopts “hdcb” OPTION
  do
    case $OPTION in
      h)
        usage
        exit 1
        ;;
      e)
        installDocker
        ;;
      c)
        installDockerCompose
        ;;
      b)
        buildImages
        ;;
      ?)
        usage
        exit
        ;;
    esac
  done
fi
