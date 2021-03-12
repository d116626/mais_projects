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

CREATE VIEW gabinete-sv.br_sp_alesp.tramitacao_natureza AS
SELECT 
SAFE_CAST(id_natureza AS STRING) id_natureza,
SAFE_CAST(nome_natureza AS STRING) nome_natureza,
SAFE_CAST(sigla_natureza AS STRING) sigla_natureza,
SAFE_CAST(tipo_natureza AS STRING) tipo_natureza
from gabinete-sv.br_sp_alesp_staging.tramitacao_natureza as t