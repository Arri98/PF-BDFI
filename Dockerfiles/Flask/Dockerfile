FROM python:3.7

WORKDIR /python_flask

RUN git clone https://github.com/ging/practica_big_data_2019

RUN pip install -r ./practica_big_data_2019/requirements.txt

ENV PROJECT_HOME=/python_flask/practica_big_data_2019

CMD ["python3", "/python_flask/practica_big_data_2019/resources/web/predict_flask.py"]
