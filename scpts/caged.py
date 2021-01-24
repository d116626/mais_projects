import pandas as pd
import numpy as np
import yaml
import time
import datetime
import os
import requests
import shutil
import urllib.request as request
from contextlib import closing


def download_caged_file(ano, mes, raw_path):
    ## cria link e path das pastas
    download_link = (
        f"ftp://ftp.mtps.gov.br/pdet/microdados/CAGED/{ano}/CAGEDEST_{mes}{ano}.7z"
    )
    download_path_year = raw_path + f"{ano}"
    download_path_month = download_path_year + f"/{int(mes)}/"

    ## cria pastas
    if os.path.exists(download_path_year):
        if os.path.exists(download_path_month):
            pass
        else:
            os.mkdir(download_path_month)
    else:
        os.mkdir(download_path_year)
        if os.path.exists(download_path_month):
            pass
        else:
            os.mkdir(download_path_month)

    filename = f"CAGEDEST_{mes}{ano}.7z"

    ## verifica se arquivo ja existe
    if os.path.exists(os.path.join(download_path_month, filename)):
        print(f"{mes}/{ano} ja existe")
    else:
        ti = time.time()
        ## download do arquivo
        with closing(request.urlopen(download_link)) as r:
            with open(os.path.join(download_path_month, filename), "wb") as f:
                shutil.copyfileobj(r, f)
        tf = time.time()
        t = time.strftime("%M:%S", time.gmtime((tf - ti)))
        print(f"{mes}/{ano} criado em {t}")
