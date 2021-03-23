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

    ### cria pasta data caso n exista
    if not os.path.exists("../data"):
        os.mkdir("../data")

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
    # print(path_month)
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
        try:

            df = pd.read_csv(
                f"{path_month}{filename_txt}.txt",
                sep=";",
                encoding="latin-1",
                nrows=save_rows,
            )
        except:
            ## caso de erro de bad lines por conter um ; extra no arquivo txt
            with open(
                f"{path_month}{filename_txt}.txt",
                encoding="latin-1",
            ) as f:
                newText = f.read().replace(";99;", ";99")

            with open(f"{path_month}{filename_txt}.txt", "w") as f:
                f.write(newText)

            df = pd.read_csv(
                f"{path_month}{filename_txt}.txt",
                sep=";",
                encoding="latin-1",
                nrows=save_rows,
            )

        df.columns = manipulation.normalize_cols(df.columns)

        df.to_csv(f"{path_month}{filename}.csv", index=False, encoding="utf-8")

        os.remove(f"{path_month}{filename_txt}.txt")


def padroniza_novo_caged(df, municipios):
    ## cria coluna ano e mes apartir da competencia declarada
    df["ano"] = df["competencia_declarada"].apply(lambda x: int(str(x)[:4]))
    df["mes"] = df["competencia_declarada"].apply(lambda x: int(str(x)[4:]))

    ## cria colunas que nao existem em outros arquivos
    if df["ano"].unique()[0] <= 2019:
        check_cols = ["ind_trab_parcial", "ind_trab_intermitente"]
        create_cols = [col for col in check_cols if col not in df.columns.tolist()]

        for col in create_cols:
            df[col] = np.nan

        hard_coded_cols = [
            "admitidos_desligados",
            "competencia_declarada",
            "municipio",
            "ano_declarado",
            "cbo_2002_ocupacao",
            "cnae_10_classe",
            "cnae_20_classe",
            "cnae_20_subclas",
            "faixa_empr_inicio_jan",
            "grau_instrucao",
            "qtd_hora_contrat",
            "ibge_subsetor",
            "idade",
            "ind_aprendiz",
            "ind_portador_defic",
            "raca_cor",
            "salario_mensal",
            "saldo_mov",
            "sexo",
            "tempo_emprego",
            "tipo_estab",
            "tipo_defic",
            "tipo_mov_desagregado",
            "uf",
            "bairros_sp",
            "bairros_fortaleza",
            "bairros_rj",
            "distritos_sp",
            "regioes_adm_df",
            "mesorregiao",
            "microrregiao",
            "regiao_adm_rj",
            "regiao_adm_sp",
            "regiao_corede",
            "regiao_corede_04",
            "regiao_gov_sp",
            "regiao_senac_pr",
            "regiao_senai_pr",
            "regiao_senai_sp",
            "subregiao_senai_pr",
            "ind_trab_parcial",
            "ind_trab_intermitente",
        ]

        df.columns = hard_coded_cols
    else:
        # remove colunas redundantes
        df = df.drop(
            ["competencia_declarada", "uf", "regiao"],
            1,
        )

    # renomeia municipio para padrao do diretorio de municipios
    rename_cols = {
        "municipio": "id_municipio_6",
    }
    df = df.rename(columns=rename_cols)

    # adiciona id_municio do diretorio de municipios
    df = df.merge(municipios, on="id_municipio_6", how="left")

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
            df[col] = pd.to_numeric(
                df[col].str.replace(",", "."), downcast="float", errors="coerce"
            )
        else:
            df[col] = np.where(df[col].str.contains("{ñ"), np.nan, df[col])

    df = df[df["sigla_uf"].notnull()]

    return df


def rename_novo_caged(df, option):
    rename_cols_estabelecimentos = {
        "competaancia": "competencia_declarada",
        "regiao": "regiao",
        "uf": "uf",
        "municapio": "municipio",
        "seaao": "cnae_20_classe",
        "subclasse": "cnae_20_subclas",
        "admitidos": "admitidos",
        "desligados": "desligados",
        "fonte_desl": "fonte_desligamento",
        "saldomovimentaaao": "saldo_movimentacao",
        "tipoempregador": "tipo_empregador",
        "tipoestabelecimento": "tipo_estab",
        "tamestabjan": "faixa_empr_inicio_jan",
    }

    rename_cols_movimentacao = {
        "competaancia": "competencia_declarada",
        "regiao": "regiao",
        "uf": "uf",
        "municapio": "municipio",
        "seaao": "cnae_20_classe",
        "subclasse": "cnae_20_subclas",
        "saldomovimentaaao": "saldo_mov",
        "cbo2002ocupaaao": "cbo_2002_ocupacao",
        "categoria": "categoria_trabalhador",
        "graudeinstruaao": "grau_instrucao",
        "idade": "idade",
        "horascontratuais": "qtd_hora_contrat",
        "raaacor": "raca_cor",
        "sexo": "sexo",
        "tipoempregador": "tipo_empregador",
        "tipoestabelecimento": "tipo_estab",
        "tipomovimentaaao": "tipo_movimentacao",
        "tipodedeficiaancia": "tipo_defic",
        "indtrabintermitente": "ind_trab_intermitente",
        "indtrabparcial": "ind_trab_parcial",
        "salario": "salario_mensal",
        "tamestabjan": "faixa_empr_inicio_jan",
        "indicadoraprendiz": "ind_aprendiz",
        "fonte": "fonte_movimentacao",
    }

    if option == "movimentacao":
        df = df.rename(columns=rename_cols_movimentacao)
    else:
        df = df.rename(columns=rename_cols_estabelecimentos)

    return df