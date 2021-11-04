FROM mongo:4.0.5


RUN apt-get update \
  && apt-get -y install curl \
  && apt-get -y install git

RUN git clone https://github.com/ging/practica_big_data_2019

WORKDIR practica_big_data_2019

RUN chmod 777 resources/import_distances.sh
RUN ./resources/download_data.sh

CMD mongod --bind_ip 11.0.0.6,127.0.0.1 & sleep 5 & ./resources/import_distances.sh && while true; do sleep 1000; done
