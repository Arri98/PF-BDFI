FROM mongo:4.2

COPY import_distances.sh /files/
COPY download_data.sh /files/

RUN apt-get update
RUN apt-get install curl
RUN chmod 777 /files/import_distances.sh 
RUN /files/download_data.sh

CMD mongod -bind_ip 11.0.0.6,127.0.0.1 && /files/import_distances.sh
