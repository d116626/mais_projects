import pandas as pd
import numpy as np

from itertools import product
from itertools import product

# top_20_final = (
#     resultado_top_20[["ano", "cargo", "sigla_partido", "nome_urna_candidato"]]
#     .drop_duplicates(subset=["nome_urna_candidato"])
#     .to_dict(orient="records")
# )


def get_final_table(cadidato_resultado, candidatos, municipios, pib_municipios):

    ## apenas eleicao ordinaria
    mask = cadidato_resultado["tipo_eleicao"] == "eleicao ordinaria"
    df_resultado = cadidato_resultado[mask]

    ## seleciona colunas de interesse
    candidatos_cols = [
        "ano",
        "sigla_uf",
        "id_municipio_tse",
        "sequencial_candidato",
        "cpf",
        "nome_urna_candidato",
        "numero_candidato",
        "sigla_partido",
        "numero_partido",
        "cargo",
        "situacao",
        "genero",
        "instrucao",
        "idade",
        "ocupacao",
        "estado_civil",
        "raca",
    ]
    df_candidatos = candidatos[candidatos_cols]
    df_candidatos["sequencial_candidato"] = df_candidatos[
        "sequencial_candidato"
    ].astype(str)

    ## put the variables of interest from candidatos in resultado
    df = df_resultado.merge(
        df_candidatos,
        on=[
            "ano",
            "sigla_uf",
            "id_municipio_tse",
            "sigla_partido",
            "cargo",
            "numero_candidato",
        ],
        how="left",
    )

    # remove null candidates, whidout result and second turn
    mask = df["tipo_eleicao"].notnull()
    df = df[mask]
    df["contagem"] = 1

    # second turn
    # mask = (df["turno"] != "2") | (df["genero"].notnull())
    mask = df["genero"].notnull()

    df = df[mask]

    # categorical transformation
    bins = pd.IntervalIndex.from_tuples(
        [(0, 30), (30, 40), (40, 50), (50, 60), (60, 999)]
    )
    intervals = bins.values
    labels = ["até 30 anos", "30 a 40 anos", "40 a 50 anos", "50 a 60 anos", "60 mais"]
    to_name = {interval: label for interval, label in zip(intervals, labels)}

    bined = pd.cut(df["idade"], bins, labels)
    bin_serie = pd.Series(pd.CategoricalIndex(bined).rename_categories(to_name))

    df["faixa_etaria"] = bin_serie

    ######## ============ pib percapta ============########
    pib_municipios_tse = pib_municipios.merge(municipios, on="id_municipio")
    pib_municipios_tse["pib_percapita"] = (
        pib_municipios_tse["PIB"] / pib_municipios_tse["populacao"]
    )

    # categorical transformation
    bins = pd.IntervalIndex.from_tuples(
        [
            (0, 20000),
            (20000, 50000),
            (50000, 100000),
            (100000, 500000),
            (500000, 999999999),
        ]
    )
    intervals = bins.values
    labels = [
        "0 a 20 mil",
        "20 a 50 mil",
        "50 a 100 mil",
        "100 a 500 mil",
        "maior 500 mil",
    ]
    to_name = {interval: label for interval, label in zip(intervals, labels)}

    bined = pd.cut(pib_municipios_tse["populacao"], bins, labels)
    bin_serie = pd.Series(pd.CategoricalIndex(bined).rename_categories(to_name))

    ## porte municipal e decil
    pib_municipios_tse["porte_municipal"] = bin_serie
    pib_municipios_tse["decil"] = pd.qcut(
        pib_municipios_tse["pib_percapita"], 10, labels=False
    )

    # pass 2018 as 2020
    pib_municipios_tse["ano"] = np.where(
        pib_municipios_tse["ano"] == 2018, 2020, pib_municipios_tse["ano"]
    )

    ######## ============ final table ============########

    final_table = df.merge(
        pib_municipios_tse, on=["ano", "id_municipio_tse"], how="left"
    )
    final_table = final_table[final_table["sequencial_candidato"].notnull()]
    return final_table


def get_values(escolas, total_rede, col):
    group_cols_0 = ["mesorregiao", "rede"]
    value = (
        escolas.groupby(by=group_cols_0 + [col], as_index=False).sum().drop("ano", 1)
    )
    dd = value.merge(total_rede, on=group_cols_0, how="outer")
    dd[f"{col}_percent"] = round(100 * dd["count"] / dd["total"], 2)
    dd = dd.drop(["count", "total"], 1)
    aa.merge(
        all_options.rename(columns={"option": "agua_potavel"}),
        on=["mesorregiao", "rede", "agua_potavel"],
        how="outer",
    )


def group_dfs(df, g_cols, select_cols, atributo):
    list_products = []
    for col in g_cols + atributo:
        lx = df[col].unique().tolist()
        list_products.append(lx)
    combination = product(*list_products)
    midx = pd.DataFrame(
        list(combination),
        columns=g_cols + atributo,
    )
    df_grouped = (
        df[g_cols + atributo + select_cols]
        .groupby(by=g_cols + atributo, as_index=False)
        .sum()
    )

    return (
        df_grouped.merge(midx, on=g_cols + atributo, how="right")
        .sort_values(by=g_cols)
        .fillna(0)
    )


def group_genero_raca(df, group_cols, select_cols, atributo, out_path=None, save=False):
    ## remove valores em que o atributo nao foi declarado
    if atributo is not None:
        mask = df[atributo].notnull()
        df = df[mask]

    atributo = [] if atributo is None else [atributo]
    ### total
    g_cols = [col for col in group_cols if col is not "raca"]
    df_total = group_dfs(df, g_cols, select_cols, atributo)
    df_total = df_total[g_cols + atributo + select_cols].rename(
        columns={"contagem": "eleitos_total", "votos": "votos_total"}
    )

    ### atributo
    df_atributo = group_dfs(df, group_cols, select_cols, atributo)
    df_atributo = df_atributo[group_cols + atributo + select_cols].rename(
        columns={"contagem": "eleitos", "votos": "votos"}
    )

    df_atributo = df_atributo.merge(df_total, on=g_cols + atributo)

    df_atributo["eleitos_proporcional"] = (
        df_atributo["eleitos"] / df_atributo["eleitos_total"]
    )
    df_atributo["votos_proporcional"] = (
        df_atributo["votos"] / df_atributo["votos_total"]
    )

    df_atributo = df_atributo[
        group_cols
        + atributo
        + [
            "eleitos",
            "eleitos_total",
            "eleitos_proporcional",
            "votos",
            "votos_total",
            "votos_proporcional",
        ]
    ]

    if atributo != [] and save == True:
        df_atributo.to_csv(f"{out_path}{atributo[0]}.csv", index=False)

    return df_atributo, df_total


def get_financeiro_bens(final_table, bens, receita, despesa):
    receita["sequencial_candidato"] = receita["sequencial_candidato"].astype(str)
    despesa["sequencial_candidato"] = despesa["sequencial_candidato"].astype(str)
    bens["sequencial_candidato"] = bens["sequencial_candidato"].astype(str)

    ### prepara tabela final
    mask = final_table["genero"].notnull()
    final_table = final_table[mask]

    cols = [
        "ano",
        "sigla_uf",
        "id_municipio_tse",
        "numero_candidato",
        "sequencial_candidato",
        "sigla_partido",
        "genero",
        "raca",
        "contagem",
        "resultado",
        "cargo",
    ]
    final_table = final_table[cols]

    merge_cols = [
        "ano",
        "sequencial_candidato",
    ]
    ## seleciona apenas segundo turno
    # mask = receita["turno"] != 2

    receita_interesse = receita.copy()

    receita_interesse["origem_receita"] = receita_interesse["origem_receita"].fillna(
        "nao_informada"
    )
    receita_interesse["origem_receita"] = np.where(
        receita_interesse["origem_receita"] == None,
        "nao_informada",
        receita_interesse["origem_receita"],
    )

    receita_soma = receita_interesse.groupby(
        by=merge_cols + ["origem_receita", "fonte_receita"],
        as_index=False,
    ).sum()

    receita_final = final_table.merge(receita_soma, how="inner", on=merge_cols)

    ## soma bens
    bens_sum = (
        bens.groupby(by=merge_cols, as_index=False)
        .sum()
        .rename(columns={"valor_item": "patrimonio"})
    )
    bens_final = final_table.merge(bens_sum, how="inner", on=merge_cols)

    # ## soma despesas
    despesa["valor_despesa"] = pd.to_numeric(despesa["valor_despesa"], errors="coerce")
    despesa_sum = despesa.groupby(by=merge_cols, as_index=False).sum()
    despesa_final = final_table.merge(despesa_sum, how="inner", on=merge_cols)

    return receita_final, despesa_final, bens_final


def group_receita(df, group_cols, select_cols, atributo=None):

    if atributo is not None:
        mask = df[atributo].notnull()
        df = df[mask]

    atributo = [] if atributo is None else [atributo]
    ### total
    g_cols = [col for col in group_cols if col is not "raca"]
    df_total = group_dfs(df, g_cols, select_cols, atributo)
    df_total = df_total[g_cols + atributo + select_cols].rename(
        columns={
            "contagem": "candidatos_total",
            select_cols[1]: "valor_receita_total",
        }
    )

    ### atributo
    df_atributo = group_dfs(df, group_cols, select_cols, atributo)
    df_atributo = df_atributo[group_cols + atributo + select_cols].rename(
        columns={"contagem": "candidatos", select_cols[1]: "valor_receita"}
    )

    df_atributo = df_atributo.merge(df_total, on=g_cols + atributo)

    df_atributo["candidatos_proporcional"] = (
        df_atributo["candidatos"] / df_atributo["candidatos_total"]
    )
    df_atributo["valor_receita_proporcional"] = (
        df_atributo["valor_receita"] / df_atributo["valor_receita_total"]
    )

    df_atributo = df_atributo[
        group_cols
        + atributo
        + [
            "candidatos",
            "candidatos_total",
            "candidatos_proporcional",
            "valor_receita",
            "valor_receita_total",
            "valor_receita_proporcional",
        ]
    ]

    df_atributo["valor_receita_per_capta"] = (
        df_atributo["valor_receita"] / df_atributo["candidatos"]
    )

    return df_atributo, df_total


def demanda_adicional(
    cadidato_resultado, candidatos, municipios, pib_municipios, receita
):
    candidatos["sequencial_candidato"] = candidatos["sequencial_candidato"].astype(str)

    ### carrega tabela consolidada
    final_table = get_final_table(
        cadidato_resultado, candidatos, municipios, pib_municipios
    )

    ### adiciona coluna de reeleição 2020
    mask = final_table["resultado"].isin(
        ["eleito por qp", "eleito por media", "eleito"]
    )

    eleitos = final_table[mask]
    eleitos = eleitos.drop_duplicates(
        subset=["ano", "cpf", "cargo", "id_municipio_tse"]
    )
    reeleitos = (
        eleitos[["cargo", "cpf", "contagem"]]
        .groupby(["cargo", "cpf"], as_index=False)
        .sum()
    )
    reeleitos["reeleito_2020"] = np.where(reeleitos["contagem"] == 2, "s", "n")
    reeleitos = reeleitos.drop("contagem", 1)

    final_table = final_table.merge(reeleitos, on=["cargo", "cpf"], how="left")
    final_table = final_table.merge(
        candidatos[["ano", "sequencial_candidato", "nome_candidato"]],
        how="left",
        on=["ano", "sequencial_candidato"],
    )

    ### remove valores preenchidos errado de receita
    receita["sequencial_candidato"] = receita["sequencial_candidato"].astype(str)

    ### agrupa receita por candidato
    receita_candidato = (
        receita[["sequencial_candidato", "ano", "valor_receita"]]
        .groupby(by=["ano", "sequencial_candidato"], as_index=False)
        .sum()
    )

    final_table["sequencial_candidato"] = final_table["sequencial_candidato"].astype(
        str
    )
    receita_candidato["sequencial_candidato"] = receita_candidato[
        "sequencial_candidato"
    ].astype(str)

    ### gera tabela final
    tabela_final = final_table.merge(
        receita_candidato, how="left", on=["ano", "sequencial_candidato"]
    ).drop("contagem", 1)
    tabela_final = tabela_final.drop_duplicates(
        subset=["ano", "sequencial_candidato", "valor_receita"]
    )
    tabela_final = tabela_final.rename(columns={"decil": "decil_pib"})

    return tabela_final
