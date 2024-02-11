FROM python:3.9

RUN apt-get install wget
RUN pip install pandas Pyarrow SQLAlchemy psycopg2-binary

WORKDIR /app

COPY ingest_yellow_taxi_data.py ingest_yellow_taxi_data.py

ENTRYPOINT [ "python", "ingest_yellow_taxi_data.py" ]
