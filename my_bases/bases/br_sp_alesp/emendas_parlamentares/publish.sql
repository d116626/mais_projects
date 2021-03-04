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

CREATE VIEW gabinete-sv.br_sp_alesp.emendas_parlamentares AS
SELECT 
SAFE_CAST(parlamentar AS STRING) parlamentar,
SAFE_CAST(entidade_beneficiada AS STRING) entidade_beneficiada,
SAFE_CAST(municipio AS STRING) municipio,
SAFE_CAST(cnpj AS STRING) cnpj,
SAFE_CAST(orgao AS STRING) orgao,
SAFE_CAST(objeto AS STRING) objeto,
SAFE_CAST(valor AS INT64) valor
from gabinete-sv.br_sp_alesp_staging.emendas_parlamentares as t
