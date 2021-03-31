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

CREATE VIEW gabinete-sv.br_sp_alesp.tramitacao_documento_regime AS
SELECT 
SAFE_CAST(data_fim AS STRING) data_fim,
SAFE_CAST(data_inicio AS STRING) data_inicio,
SAFE_CAST(id_documento AS STRING) id_documento,
SAFE_CAST(id_regime AS STRING) id_regime,
SAFE_CAST(nome_regime AS STRING) nome_regime
from gabinete-sv.br_sp_alesp_staging.tramitacao_documento_regime as t