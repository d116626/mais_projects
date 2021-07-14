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

CREATE VIEW gabinete-sv.br_sp_alesp.tramitacao_documento_andamento_atual AS
SELECT 
SAFE_CAST(descricao AS STRING) descricao,
SAFE_CAST(data AS STRING) data,
SAFE_CAST(id_comissao AS STRING) id_comissao,
SAFE_CAST(id_documento AS STRING) id_documento,
SAFE_CAST(id_etapa AS STRING) id_etapa,
SAFE_CAST(id_tipo_andamento AS STRING) id_tipo_andamento,
SAFE_CAST(nome_etapa AS STRING) nome_etapa,
SAFE_CAST(numero_ordem AS STRING) numero_ordem,
SAFE_CAST(tipo_andamento AS STRING) tipo_andamento
from gabinete-sv.br_sp_alesp_staging.tramitacao_documento_andamento_atual as t