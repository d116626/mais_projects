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
    tb = Table("microdados_antigo", "br_me_caged")

    # tb.create(
    #     path='../data/caged/clean/caged_antigo/2019/',
    #     if_table_exists='replace',
    #     if_storage_data_exists='replace',
    #     if_table_config_exists='pass'
    # )

    for ano in range(2014, 2019):
        tb.append(
            filepath=f"../data/caged/clean/caged_antigo/{ano}/",
            partitions="ano=value/mes=value/sigla_uf=value",
            if_exists="replace",
        )
        print(f"{ano} done!\n")

    tb.publish(if_exists="replace")


if __name__ == "__main__":
    main()