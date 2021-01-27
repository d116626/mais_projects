import sys
sys.path.insert(0, "../")

import time
import os

import pandas as pd
import numpy as np

import shutil
import urllib.request as request
from contextlib import closing

import py7zr

from scpts import manipulation


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


def get_file_names_and_clean_residues(path_month):
    filename_7z = [file for file in os.listdir(path_month) if ".7z" in file][0][:-3]
    filename_txt = [file for file in os.listdir(path_month) if ".txt" in file]
    filename_csv = [file for file in os.listdir(path_month) if ".csv" in file]

    if filename_txt != []:
        os.remove(f"{path_month}{filename_txt[0][:-4] }.txt")
    if filename_csv != []:
        os.remove(f"{path_month}{filename_csv[0][:-4]}.csv")

    return filename_7z


def make_dirs(path, folder, var):
    if os.path.exists(f"{path}{var}={folder}/"):
        pass
    else:
        os.mkdir(f"{path}{var}={folder}/")


def make_folder_tree(clean_path, ano, mes, uf="SP"):
    make_dirs(clean_path, ano, var="ano")
    path_ano = f"{clean_path}/ano={ano}/"
    make_dirs(path_ano, mes, var="mes")
    path_mes = f"{clean_path}/ano={ano}/mes={mes}/"
    make_dirs(path_mes, uf, var="sigla_uf")
    path_uf = f"{clean_path}/ano={ano}/mes={mes}/sigla_uf={uf}/"
    return path_uf


def extract_file(path_month, filename, save_rows=10):
    if os.path.exists(f"{path_month}{filename}.csv"):
        pass
    else:
        archive = py7zr.SevenZipFile(f"{path_month}{filename}.7z", mode="r").extractall(
            path=path_month
        )

        filename_txt = [file for file in os.listdir(path_month) if ".txt" in file][0][
            :-4
        ]

        df = pd.read_csv(
            f"{path_month}{filename_txt}.txt",
            sep=";",
            encoding="latin-1",
            nrows=save_rows,
        )

        df.columns = manipulation.normalize_cols(df.columns)

        df.to_csv(f"{path_month}{filename}.csv", index=False, encoding="utf-8")

        os.remove(f"{path_month}{filename_txt}.txt")


def padroniza_caged(df, municipios):
    ## cria colunas que nao existem em outros arquivos
    check_cols = ["ind_trab_parcial", "ind_trab_intermitente"]
    create_cols = [col for col in check_cols if col not in df.columns.tolist()]

    for col in create_cols:
        df[col] = np.nan

    ## cria coluna ano e mes apartir da competencia declarada
    df["ano"] = df["competencia_declarada"].apply(lambda x: int(str(x)[:4]))
    df["mes"] = df["competencia_declarada"].apply(lambda x: int(str(x)[4:]))
    df = df.drop([], 1)

    # renomeia municipio para padrao do diretorio de municipios
    rename_cols = {
        "municipio": "id_municipio_6",
    }
    df = df.rename(columns=rename_cols)

    # adiciona id_municio do diretorio de municipios
    df = df.merge(municipios, on="id_municipio_6", how="left")

    # remove colunas redundantes
    df = df.drop(
        ["competencia_declarada", "ano_declarado", "uf", "mesorregiao", "microrregiao"],
        1,
    )

    # organiza a ordem das colunas
    first_cols = ["ano", "mes", "sigla_uf", "id_municipio", "id_municipio_6"]
    all_cols = first_cols + [
        col for col in df.columns.tolist() if col not in first_cols
    ]
    df = df[all_cols]

    # remove strings do tipo {ñ e converte salario e tempo de emprego para float
    objct_cols = df.select_dtypes(include=["object"]).columns.tolist()

    for col in objct_cols:
        if col == "salario_mensal" or col == "tempo_emprego":
            df[col] = df[col].str.replace(",", ".").astype(float)
        else:
            df[col] = np.where(df[col].str.contains("{ñ"), np.nan, df[col])

    return df