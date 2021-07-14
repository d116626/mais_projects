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

CREATE VIEW gabinete-sv.br_sp_alesp.tramitacao_comissoes_permanentes_reunioes AS
SELECT 
SAFE_CAST(situacao AS STRING) situacao,
SAFE_CAST(data AS STRING) data,
SAFE_CAST(id_comissao AS STRING) id_comissao,
SAFE_CAST(id_pauta AS STRING) id_pauta,
SAFE_CAST(idreuniao AS STRING) idreuniao,
SAFE_CAST(presidente AS STRING) presidente,
SAFE_CAST(numero_convocacao AS STRING) numero_convocacao,
SAFE_CAST(numero_legislatura AS STRING) numero_legislatura,
SAFE_CAST(tipo_convocacao AS STRING) tipo_convocacao,
SAFE_CAST(codigo_situacao AS STRING) codigo_situacao
from gabinete-sv.br_sp_alesp_staging.tramitacao_comissoes_permanentes_reunioes as t