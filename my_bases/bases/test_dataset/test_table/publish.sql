/*

Query para publicar a tabela.

Esse é o lugar para:
    - modificar nomes, ordem e tipos de colunas
    - dar join com outras tabelas
    - criar colunas extras (e.g. logs, proporções, etc.)

Qualquer coluna definida aqui deve também existir em `table_config.yaml`.

# Além disso, sinta-se à vontade para alterar alguns nomes obscuros
# para algo um pouco mais explícito.

TIPOS:
    - Para modificar tipos de colunas, basta substituir STRING por outro tipo válido.
    - Exemplo: `SAFE_CAST(column_name AS NUMERIC) column_name`
    - Mais detalhes: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-types

*/

CREATE VIEW gabinete-sv.test_dataset.test_table AS
SELECT 
SAFE_CAST(id_municipio AS STRING) id_municipio,
SAFE_CAST(id_municipio_6 AS STRING) id_municipio_6,
SAFE_CAST(cnae_20_classe AS STRING) cnae_20_classe,
SAFE_CAST(cnae_20_subclas AS STRING) cnae_20_subclas,
SAFE_CAST(admitidos AS STRING) admitidos,
SAFE_CAST(desligados AS STRING) desligados,
SAFE_CAST(fonte_desligamento AS STRING) fonte_desligamento,
SAFE_CAST(saldo_movimentacao AS STRING) saldo_movimentacao,
SAFE_CAST(tipo_empregador AS STRING) tipo_empregador,
SAFE_CAST(tipo_estab AS STRING) tipo_estab,
SAFE_CAST(faixa_empr_inicio_jan AS STRING) faixa_empr_inicio_jan,
SAFE_CAST(ano AS STRING) ano,
SAFE_CAST(mes AS STRING) mes,
SAFE_CAST(sigla_uf AS STRING) sigla_uf
from gabinete-sv.test_dataset_staging.test_table as t