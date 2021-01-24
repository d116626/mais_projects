#!/usr/bin/python3
import pandas as pd
import numpy as np
import pandas_gbq
import pydata_google_auth
import gspread
from gcloud import storage
from google.oauth2 import service_account
from oauth2client.service_account import ServiceAccountCredentials
import os
from os import listdir
import requests
import json
from datetime import datetime
from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot, offline
from selenium import webdriver
from selenium.webdriver.support.ui import Select
import time
from datetime import datetime

today = datetime.today().strftime("%Y-%m-%d")

import sys

sys.path.insert(0, "../")

from scpts import manipulation

os.environ[
    "GOOGLE_APPLICATION_CREDENTIALS"
] = "../../credentials/gabinete_sv_credentials.json"


def read_sheets(sheet_name, workSheet=0):

    scope = [
        "https://spreadsheets.google.com/feeds",
        "https://www.googleapis.com/auth/drive",
    ]

    credentials = ServiceAccountCredentials.from_json_keyfile_name(
        "../../../credentials/gabinete-sv-9aed310629e5.json", scope
    )
    gc = gspread.authorize(credentials)
    if workSheet == 0:
        wks = gc.open(sheet_name).sheet1
    else:
        wks = gc.open(sheet_name).worksheet(workSheet)

    data = wks.get_all_values()
    headers = data.pop(0)

    return pd.DataFrame(data, columns=headers)


def _get_credentials_gbq():

    SCOPES = [
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/drive",
    ]

    credentials = pydata_google_auth.get_user_credentials(
        SCOPES,
        # Set auth_local_webserver to True to have a slightly more convienient
        # authorization flow. Note, this doesn't work if you're running from a
        # notebook on a remote sever, such as over SSH or with Google Colab.
        auth_local_webserver=True,
    )

    return credentials


def to_gbq(
    df, table_name, schema_name="simula_corona", project_id="robusta-lab", **kwargs
):
    """
    write a dataframe in Google BigQuery
    , if_exists='replace'
    """

    destination_table = f"{schema_name}.{table_name}"

    pandas_gbq.to_gbq(
        df, destination_table, project_id, credentials=_get_credentials_gbq(), **kwargs
    )


def read_gbq(query, project_id="robusta-lab", **kwargs):
    """
    write a dataframe in Google BigQuery
    """

    return pandas_gbq.read_gbq(
        query, project_id, credentials=_get_credentials_gbq(), **kwargs
    )


def to_storage(bucket, bucket_folder, file_name, path_to_file):

    client = storage.Client(project="gavinete-sv")
    bucket = client.get_bucket(f"{bucket}")
    blob = bucket.blob(f"{bucket_folder}/{file_name}")
    blob.upload_from_filename(f"{path_to_file}")

    print("Done!")
