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


def main():
    # ### Padroniza CAGED ANTIGO AJUSTES
    # clean_save_path = "../data/caged/clean/caged_antigo_ajustes/"
    # folders = glob.glob("../data/caged/raw/caged_antigo_ajustes/*/*/")
    # municipios = pd.read_parquet("../data/caged/raw/municipios.parquet")

    # caged.caged_antigo_padronize_and_partitioned(
    #     folders, clean_save_path, municipios, force_remove_csv=False
    # )

    ### Padroniza CAGED ANTIGO
    # clean_save_path = "../data/caged/clean/caged_antigo/"
    # folders = glob.glob("../data/caged/raw/caged_antigo/*/*/")
    # municipios = pd.read_parquet("../data/caged/raw/municipios.parquet")

    # caged.caged_antigo_padronize_and_partitioned(
    #     folders[1:], clean_save_path, municipios, force_remove_csv=False
    # )

    # CAGED ANTIGO AJUSTES

    # tb = Table("microdados_antigo_ajutes", "br_me_caged")

    # tb.create(
    #     path="../data/caged/clean/caged_antigo_ajustes/2019/",
    #     if_table_exists="replace",
    #     if_storage_data_exists="replace",
    #     if_table_config_exists="pass",
    # )

    # tb.publish(if_exists="replace")

    # for ano in range(2007, 2019):
    #     tb.append(
    #         filepath=f"../data/caged/clean/caged_antigo_ajustes/{ano}/",
    #         partitions="ano=value/mes=value/sigla_uf=value",
    #         if_exists="replace",
    #     )
    #     print(f"{ano} done!\n")

    # tb.publish(if_exists='replace')

    # CAGED ANTIGO PADRAO

    tb = Table("microdados_antigo", "br_me_caged")

    # tb.create(
    #     path="../data/caged/clean/caged_antigo/2019/",
    #     if_table_exists="replace",
    #     if_storage_data_exists="replace",
    #     if_table_config_exists="pass",
    # )

    # tb.publish(if_exists="replace")

    for ano in range(2016, 2019):
        tb.append(
            filepath=f"../data/caged/clean/caged_antigo/{ano}/",
            partitions="ano=value/mes=value/sigla_uf=value",
            if_exists="replace",
        )
        print(f"{ano} done!\n")

    tb.publish(if_exists="replace")


if __name__ == "__main__":
    main()