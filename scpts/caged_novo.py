import os
import shutil

import urllib.request as request
from contextlib import closing

import re

import time
from datetime import datetime

today = datetime.strftime(datetime.today(), "%Y-%m-%d")

import pandas as pd

month_number_dict = {
    "04": "Abril",
    "08": "Agosto",
    "12": "Dezembro",
    "02": "Fevereiro",
    "01": "Janeiro",
    "07": "Julho",
    "06": "Junho",
    "05": "Maio",
    "03": "Março",
    "11": "Novembro",
    "10": "Outubro",
    "09": "Setembro",
}

month_name_dict = {
    "Abril": "04",
    "Agosto": "08",
    "Dezembro": "12",
    "Fevereiro": "02",
    "Janeiro": "01",
    "Julho": "07",
    "Junho": "06",
    "Maio": "05",
    "Março": "03",
    "Novembro": "11",
    "Outubro": "10",
    "Setembro": "09",
}


def get_urls(download_url):
    with request.urlopen(download_url) as r:
        data = r.read()
    return [line.split(" ")[-1] for line in data.decode("latin1").splitlines()]


def get_download_links():
    download_url = "ftp://ftp.mtps.gov.br/pdet/microdados/NOVO%20CAGED/"
    tipos = get_urls(download_url)
    tipos = [tipo for tipo in tipos if ".pdf" not in tipo]

    download_dict = {}
    for tipo in tipos:
        print(tipo)
        year_url = download_url + tipo + "/"
        years = get_urls(year_url)
        ## adiciona 2020 hard coded caso n exista. problema no ftp dos microdados
        years = years + ["2020"] if "2020" not in years else years

        years = [int(year) for year in years if re.findall(r"\b\d\d\d\d\b", year)]
        last_year = max(years)
        first_year = min(years)
        ##cria url com o maior ano
        months_url = year_url + f"{last_year}/"
        months_last_year = get_urls(months_url)

        ##descobre o maior mes do maior ano
        last_month = max(int(month_name_dict[month]) for month in months_last_year)
        last_month_number = f"0{last_month}" if last_month <= 9 else str(last_month)
        last_month_name = month_number_dict[last_month_number]

        ## cria url com maior ano/mes
        file_names_url = months_url + f"{last_month_name}/"
        last_year_file_names = get_urls(file_names_url)

        last_year_files_urls = [
            file_names_url + file_name for file_name in last_year_file_names
        ]

        ## lista dos ultiimos 12 arquivos atualizados
        last_year_month_dt = [month[-9:-3] for month in last_year_file_names]

        ## define ultimo mes para criar uma lista de datas, adiciona mais 1 para incluir o mes vigente
        last_month_dt = int(last_month_number) + 1
        last_month_dt = (
            f"0{last_month_dt}" if last_month_dt <= 9 else str(last_month_dt)
        )

        dates = pd.date_range(
            f"{first_year}-01-01", f"{last_year}-{last_month_dt}-01", freq="m"
        )
        dates = [str(date)[:7].replace("-", "") for date in dates]

        ## meses a serem baixados separadamente
        left_over_dates = [date for date in dates if date not in last_year_month_dt]

        left_over_files = []
        for left_date in left_over_dates:
            ano_plus = str(int(left_date[:4]) + 1)
            mes_number = left_date[4:]
            mes_name = month_number_dict[mes_number]

            ## cria url para baixar o arquivo maiis atualizado
            left_files_url = year_url + f"{ano_plus}/{mes_name}/"

            ## encontra o nome do arquivo mais atualizado
            last_year_files = get_urls(left_files_url)
            file_name = [
                last_month for last_month in last_year_files if left_date in last_month
            ][0]

            ##adiciona a lista de arquivos que sobraram
            file_url = left_files_url + file_name
            left_over_files.append(file_url)

        download_dict[tipo] = left_over_files + last_year_files_urls

    return download_dict
