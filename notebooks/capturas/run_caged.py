import warnings

warnings.filterwarnings("ignore")

import pandas as pd
import numpy as np

pd.options.display.max_columns = 999
pd.options.display.max_rows = 1999
pd.options.display.max_colwidth = 200

from paths import *
from scpts import manipulation
from scpts import io
from scpts import caged

from basedosdados import Storage, Table, Dataset
import basedosdados as bd

import glob


def filer_folders(folders, filtro):
    return (
        [
            folder
            for folder in folders
            if folder.split("/")[-3] in [str(ano) for ano in filtro]
        ]
        if filtro
        else folders
    )


def main():
    ## Padroniza CAGED ANTIGO AJUScd noteTES
    # municipios = pd.read_parquet("../data/caged/raw/municipios.parquet")
    # clean_save_path = "../data/caged/clean/caged_antigo_ajustes/"
    # folders = glob.glob("../data/caged/raw/caged_antigo_ajustes/*/*/")

    # filtro_anos = [2019]
    # folders = filer_folders(folders, filtro_anos)

    # caged.caged_antigo_padronize_and_partitioned(
    #     folders, clean_save_path, municipios, force_remove_csv=True
    # )

    ## Padroniza CAGED ANTIGO
    # municipios = pd.read_parquet("../data/caged/raw/municipios.parquet")
    # clean_save_path = "../data/caged/clean/caged_antigo/"
    # folders = glob.glob("../data/caged/raw/caged_antigo/*/*/")

    # filtro_anos = [2019]
    # folders = filer_folders(folders, filtro_anos)

    # caged.caged_antigo_padronize_and_partitioned(
    #     folders, clean_save_path, municipios, force_remove_csv=True
    # )

    ### CAGED ANTIGO AJUSTES

    # tb = Table("microdados_antigos_ajustes", "br_me_caged")

    # tb.create(
    #     path="../data/caged/clean/caged_antigo_ajustes/2019/",
    #     if_table_exists="replace",
    #     if_storage_data_exists="replace",
    #     if_table_config_exists="pass",
    # )

    # tb.publish(if_exists="replace")

    # tb = Table("microdados_antigos_ajustes", "br_me_caged")
    # for ano in range(2013, 2019):
    #     tb.append(
    #         filepath=f"../data/caged/clean/caged_antigo_ajustes/{ano}/",
    #         partitions="ano=value/mes=value/sigla_uf=value",
    #         if_exists="replace",
    #     )
    #     print(f"{ano} done!\n")

    # tb.publish(if_exists="replace")

    # CAGED ANTIGO PADRAO

    # tb = Table("microdados_antigos", "br_me_caged")

    # tb.create(
    #     path="../data/caged/clean/caged_antigo/2019/",
    #     if_table_exists="replace",
    #     if_storage_data_exists="replace",
    #     if_table_config_exists="pass",
    # )

    # tb.publish(if_exists="replace")

    tb = Table("microdados_antigos", "br_me_caged")

    for ano in range(2013, 2019):
        tb.append(
            filepath=f"../data/caged/clean/caged_antigo/{ano}/",
            partitions="ano=value/mes=value/sigla_uf=value",
            if_exists="replace",
        )
        print(f"{ano} done!\n")

    tb.publish(if_exists="replace")


if __name__ == "__main__":
    main()
