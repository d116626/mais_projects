import time
from datetime import datetime
import os
from ftplib import FTP

import unidecode
import re
import pandas as pd

import shutil
from contextlib import closing

today = datetime.strftime(datetime.today(), "%Y-%m-%d")

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


def get_ftp(url_path):
    ftp = FTP("ftp.mtps.gov.br")
    ftp.login()
    ftp.encoding = "latin1"
    path = "/pdet/microdados/NOVO CAGED/" + url_path
    ftp.cwd(path)
    return ftp


################################################################
# GET THE DOWNLOAD LINKS
################################################################


def get_download_links():
    tipos = [tipo for tipo in get_ftp("").nlst() if ".pdf" not in tipo]
    download_dict = {}

    for tipo in tipos:
        tipo_lower = unidecode.unidecode(tipo).lower()
        print(tipo_lower)
        year_url = tipo
        years = get_ftp(year_url).nlst()
        ## adiciona 2020 hard coded caso n exista. problema no ftp dos microdados
        years = years + ["2020"] if "2020" not in years else years
        years = [int(year) for year in years if re.findall(r"\b\d\d\d\d\b", year)]

        last_year = max(years)
        first_year = min(years)
        ##cria url com o maior ano
        months_url = year_url + f"/{last_year}/"
        months_last_year = get_ftp(months_url).nlst()

        ##descobre o maior mes do maior ano
        last_month = max(int(month_name_dict[month]) for month in months_last_year)
        last_month_number = f"0{last_month}" if last_month <= 9 else str(last_month)
        last_month_name = month_number_dict[last_month_number]

        ## cria url com maior ano/mes
        file_names_url = months_url + f"{last_month_name}/"
        last_year_file_names = get_ftp(file_names_url).nlst()

        last_year_files_urls = [
            file_names_url + file_name for file_name in last_year_file_names
        ]

        last_year_files_urls_path = []
        for download_url in last_year_files_urls:
            file_name = download_url.split("/")[-1]
            year = file_name.split(".")[0][-6:-2]
            month = file_name.split(".")[0][-2:]
            last_year_files_urls_path.append(f"{int(year)}/" + f"{int(month)}/")

        download_dict[tipo_lower] = {
            "must_download": dict(zip(last_year_files_urls_path, last_year_files_urls)),
            "check_download": {},
        }
        ## lista dos ultimos 12 arquivos atualizados
        last_year_month_dt = [month[-9:-3] for month in last_year_file_names]

        ## define ultimo mes para criar uma lista de datas, adiciona mais 1 para incluir o mes vigente
        last_month_dt = int(last_month_number) + 1
        last_month_dt = (
            f"0{last_month_dt}" if last_month_dt <= 9 else str(last_month_dt)
        )

        dates = [
            str(date)[:7].replace("-", "")
            for date in pd.date_range(
                f"{first_year}-01-01", f"{last_year}-{last_month_dt}-01", freq="m"
            )
        ]

        ## meses a serem baixados separadamente
        left_over_dates = [date for date in dates if date not in last_year_month_dt]
        left_over_files = []
        for left_date in left_over_dates:
            ano_plus = str(int(left_date[:4]) + 1)
            mes_number = left_date[4:]
            mes_name = month_number_dict[mes_number]

            ## cria url para baixar o arquivo mais atualizado
            left_files_url = year_url + f"/{ano_plus}/{mes_name}/"

            ## encontra o nome do arquivo mais atualizado
            last_year_files = get_ftp(left_files_url).nlst()
            file_name = [
                last_month for last_month in last_year_files if left_date in last_month
            ][0]

            ##adiciona a lista de arquivos que sobraram
            file_url = left_files_url + file_name
            left_over_files.append(file_url)

            left_date_year = left_date[:4]
            left_date_month = left_date[4:]
            left_path = f"{int(left_date_year)}/" + f"{int(left_date_month)}/"
            download_dict[tipo_lower]["check_download"][left_path] = file_url

        left_over_files

    return download_dict


################################################################
# DOWNLOAD FILES
################################################################


def creat_path_tree(path):
    current_path = ""
    for folder in path.split("/"):
        current_path += f"{folder}/"
        if folder != ".." and not os.path.isdir(current_path):
            os.mkdir(current_path)


def download_data(save_path, download_url):
    ## download do arquivo
    path_url = "/".join(download_url.split("/")[:-1])
    ftp = get_ftp(path_url)

    file_name = download_url.split("/")[-1]
    creat_path_tree(save_path)
    if not os.path.isfile(save_path + file_name):
        with open(save_path + file_name, "wb") as f:
            ftp.retrbinary("RETR " + file_name, f.write)
