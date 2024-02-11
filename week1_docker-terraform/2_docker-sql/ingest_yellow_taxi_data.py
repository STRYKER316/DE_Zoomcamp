#!/usr/bin/env python
# coding: utf-8

from time import time
import os
import argparse
import pandas as pd
from sqlalchemy import create_engine


def main(params):
    # get the parameters
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    database_name = params.database_name
    table_name = params.table_name
    csv_url = params.csv_url

    # create a connection engine for postgres
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{database_name}')

    # download the csv file
    csv_name = 'yellow_taxi_tripdata.csv'
    os.system(f'wget {csv_url} -O {csv_name}')


    df_iterator = pd.read_csv(csv_name, iterator=True, chunksize=100000)
    df = next(df_iterator)

    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    df.to_sql(name=table_name, con=engine, if_exists='append')


    while True:
        try:
            t_start = time()
            
            df = next(df_iterator)
        
            df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
            df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
        
            df.to_sql(name=table_name, con=engine, if_exists='append')
        
            t_end = time()
        
            print(f"Ingested another chunk of 100k rows to postgre, took {(t_end - t_start):.3f} sec")
        
        except StopIteration:
            print("Dataset ingestion complete")
            break



# script excution
if __name__ == '__main__':
    # collect arguments from command line and pass them to main() for execution
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--host', help='host name for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--database_name', help='database name in postgres')
    parser.add_argument('--table_name', help='table in the postgres database to which the data will be ingested')
    parser.add_argument('--csv_url', help='url of the CSV data file')

    args = parser.parse_args()

    main(args)
