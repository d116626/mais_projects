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
SAFE_CAST(ano AS STRING) ano,
SAFE_CAST(mes AS STRING) mes,
SAFE_CAST(matricula AS STRING) matricula,
SAFE_CAST(deputado AS STRING) deputado,
SAFE_CAST(cnpj AS STRING) cnpj,
SAFE_CAST(fornecedor AS STRING) fornecedor,
SAFE_CAST(tipo AS STRING) tipo,
SAFE_CAST(valor AS STRING) valor
from gabinete-sv.br_sp_alesp_staging.despesas_gabinete as t