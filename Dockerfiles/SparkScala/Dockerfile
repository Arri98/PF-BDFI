FROM ubuntu:20.04

RUN apt-get update

RUN apt-get install -y git
RUN git clone https://github.com/ging/practica_big_data_2019 

RUN apt-get install curl -y
WORKDIR practica_big_data_2019	
RUN ./resources/download_data.sh

RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install -y openjdk-8-jdk

RUN apt-get install -y python3.8 python3-pip
RUN python3 -m pip install --upgrade pip

RUN apt-get install apt-transport-https curl gnupg -yqq
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
RUN chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
RUN apt-get update
RUN apt-get install sbt


RUN curl -O https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
RUN tar xvf spark-3.1.2-bin-hadoop3.2.tgz
RUN mv spark-3.1.2-bin-hadoop3.2/ /opt/spark 
RUN echo -e "export SPARK_HOME=/opt/spark\nexport PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"  >> ~/.bashrc
CMD . ~/.bashrc

RUN apt-get install wget
RUN apt-get remove scala-library scala
RUN wget https://downloads.lightbend.com/scala/2.12.3/scala-2.12.3.deb
RUN dpkg -i scala-2.12.3.deb
RUN apt-get update
RUN apt-get install scala

RUN pip3 install -r requirements.txt

RUN ls -a /usr/lib/jvm/java-8-openjdk-amd64/jre/bin
RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 && SPARK_HOME=/opt/spark && python3 resources/train_spark_mllib_model.py .
