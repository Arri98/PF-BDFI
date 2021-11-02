FROM python:3.7

WORKDIR /python_flask

RUN git clone https://github.com/ging/practica_big_data_2019

RUN pip install -r ./practica_big_data_2019/requirements.txt

ENV PROJECT_HOME=/python_flask/practica_big_data_2019

RUN sed -i '15s/.*/client = MongoClient("mongodb:\/\/11.0.0.6:27017\/agile_data_science")/' practica_big_data_2019/resources/web/predict_flask.py
RUN sed -i '28s/.*/producer = KafkaProducer(bootstrap_servers=["11.0.0.4:9092"],api_version=(0,10))/' practica_big_data_2019/resources/web/predict_flask.py
RUN sed -i '54s/.*/   "mongodb:\/\/11.0.0.6:27017\/agile_data_science.prediction_tasks",/' practica_big_data_2019/resources/fetch_prediction_requests.py
RUN sed -i '45s/.*/   "mongodb:\/\/11.0.0.6:27017\/agile_data_science.prediction_results"/' practica_big_data_2019/resources/load_prediction_results.py
CMD ["python3", "/python_flask/practica_big_data_2019/resources/web/predict_flask.py"]
