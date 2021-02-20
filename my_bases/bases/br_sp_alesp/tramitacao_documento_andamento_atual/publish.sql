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
SAFE_CAST(Descricao AS STRING) Descricao,
SAFE_CAST(Data AS STRING) Data,
SAFE_CAST(IdComissao AS INT64) IdComissao,
SAFE_CAST(IdDocumento AS INT64) IdDocumento,
SAFE_CAST(IdEtapa AS INT64) IdEtapa,
SAFE_CAST(IdTpAndamento AS INT64) IdTpAndamento,
SAFE_CAST(NmEtapa AS STRING) NmEtapa,
SAFE_CAST(NrOrdem AS STRING) NrOrdem,
SAFE_CAST(TpAndamento AS STRING) TpAndamento
from gabinete-sv.br_sp_alesp_staging.tramitacao_documento_andamento_atual as t
