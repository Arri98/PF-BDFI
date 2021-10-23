#!/bin/bash

sudo apt-get update

sudo apt-get install -y git
git clone https://github.com/ging/practica_big_data_2019

cp practica_big_data_2019/resources/download_data.sh Dockerfiles/Mongo/download_data.sh
cp practica_big_data_2019/resources/import_distances.sh Dockerfiles/Mongo/import_distances.sh


