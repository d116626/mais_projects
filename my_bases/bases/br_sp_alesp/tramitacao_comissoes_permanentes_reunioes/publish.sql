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
SAFE_CAST(Situacao AS STRING) Situacao,
SAFE_CAST(Data AS STRING) Data,
SAFE_CAST(IdComissao AS INT64) IdComissao,
SAFE_CAST(IdPauta AS INT64) IdPauta,
SAFE_CAST(IdReuniao AS INT64) IdReuniao,
SAFE_CAST(Presidente AS STRING) Presidente,
SAFE_CAST(NrConvocacao AS STRING) NrConvocacao,
SAFE_CAST(NrLegislatura AS STRING) NrLegislatura,
SAFE_CAST(TipoConvocacao AS STRING) TipoConvocacao,
SAFE_CAST(CodSituacao AS STRING) CodSituacao
from gabinete-sv.br_sp_alesp_staging.tramitacao_comissoes_permanentes_reunioes as t
