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

CREATE VIEW gabinete-sv.br_sp_alesp.despesas_gabinete AS
SELECT 
SAFE_CAST(Ano AS INT64) Ano,
SAFE_CAST(Mes AS INT64) Mes,
SAFE_CAST(Data AS STRING) Data,
SAFE_CAST(Matricula AS INT64) Matricula,
SAFE_CAST(Deputado AS STRING) Deputado,
SAFE_CAST(CNPJ AS STRING) CNPJ,
SAFE_CAST(Fornecedor AS STRING) Fornecedor,
SAFE_CAST(Tipo AS STRING) Tipo,
SAFE_CAST(Valor AS FLOAT64) Valor
from gabinete-sv.br_sp_alesp_staging.despesas_gabinete as t
