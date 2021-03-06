FROM ubuntu:20.04

RUN apt-get update

RUN apt-get install -y git
RUN git clone https://github.com/ging/practica_big_data_2019

RUN apt-get install curl -y
WORKDIR practica_big_data_2019
RUN ./resources/download_data.sh

RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install -y openjdk-8-jdk

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
RUN wget https://downloads.lightbend.com/scala/2.12.10/scala-2.12.10.deb
RUN dpkg -i scala-2.12.10.deb
RUN apt-get update
RUN apt-get install scala

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get install -y python3.7 python3-pip
RUN python3.7 -m pip install pip
RUN python3.7 -m pip install -r requirements.txt
RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 && SPARK_HOME=/opt/spark && python3.7 resources/train_spark_mllib_model.py .
RUN sed -i '24s/.*/    val base_path= "\/practica_big_data_2019"/' flight_prediction/src/main/scala/es/upm/dit/ging/predictor/MakePrediction.scala
RUN sed -i '142s/.*/    val writeConfig = WriteConfig(Map("uri" -> "mongodb:\/\/11.0.0.6:27017\/agile_data_science.flight_delay_classification_response"))/' flight_prediction/src/main/scala/es/upm/dit/ging/predictor/MakePrediction.scala
RUN sed -i '49s/.*/      .option("kafka.bootstrap.servers", "11.0.0.4:9092")/' flight_prediction/src/main/scala/es/upm/dit/ging/predictor/MakePrediction.scala
RUN sed -i '19d' flight_prediction/src/main/scala/es/upm/dit/ging/predictor/MakePrediction.scala

RUN sed -i '54s/.*/   "mongodb:\/\/11.0.0.6:27017\/agile_data_science.prediction_tasks",/' resources/fetch_prediction_requests.py
RUN sed -i '45s/.*/   "mongodb:\/\/11.0.0.6:27017\/agile_data_science.prediction_results"/' resources/load_prediction_results.py


WORKDIR flight_prediction
RUN sbt compile package

WORKDIR ..
RUN pip3 install -r resources/airflow/requirements.txt -c resources/airflow/constraints.txt
ENV PROJECT_HOME=/practica_big_data_2019
ENV AIRFLOW_HOME=/practica_big_data_2019/resources/airflow
RUN mkdir $AIRFLOW_HOME/dags
RUN mkdir $AIRFLOW_HOME/logs
RUN mkdir $AIRFLOW_HOME/plugins
RUN airflow db init
RUN airflow users create --username admin --firstname Jack --lastname Sparrow --role Admin --email example@mail.org --password blackpearl
RUN cp resources/airflow/setup.py $AIRFLOW_HOME/dags
RUN python3 $AIRFLOW_HOME/dags/setup.py


CMD airflow webserver --port 8000 -D & airflow scheduler -D & airflow celery worker & /opt/spark/bin/spark-submit --class "es.upm.dit.ging.predictor.MakePrediction" --master  spark://11.0.0.33:7077 --deploy-mode client --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2  --total-executor-cores 4  /practica_big_data_2019/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar

