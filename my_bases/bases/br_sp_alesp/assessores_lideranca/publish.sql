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

CREATE VIEW gabinete-sv.br_sp_alesp.assessores_lideranca AS
SELECT 
SAFE_CAST(Servidor AS STRING) Servidor,
SAFE_CAST(Cargo AS STRING) Cargo,
SAFE_CAST(Lotacao AS STRING) Lotacao,
SAFE_CAST(Regime AS STRING) Regime,
SAFE_CAST(Partido AS STRING) Partido
from gabinete-sv.br_sp_alesp_staging.assessores_lideranca as t