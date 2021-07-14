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

CREATE VIEW gabinete-sv.br_sp_alesp.tramitacao_proposituras AS
SELECT 
SAFE_CAST(ano_legislativo AS STRING) ano_legislativo,
SAFE_CAST(codigo_originalidade AS STRING) codigo_originalidade,
SAFE_CAST(ementa AS STRING) ementa,
SAFE_CAST(data_entrada_sistema AS STRING) data_entrada_sistema,
SAFE_CAST(data_publicacao AS STRING) data_publicacao,
SAFE_CAST(id_documento AS STRING) id_documento,
SAFE_CAST(id_natureza AS STRING) id_natureza,
SAFE_CAST(numero_legislativo AS STRING) numero_legislativo
from gabinete-sv.br_sp_alesp_staging.tramitacao_proposituras as t