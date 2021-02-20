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

CREATE VIEW gabinete-sv.br_sp_alesp.tramitacao_comissoes_permanentes_votacoes AS
SELECT 
SAFE_CAST(Voto AS STRING) Voto,
SAFE_CAST(IdComissao AS INT64) IdComissao,
SAFE_CAST(IdDeputado AS INT64) IdDeputado,
SAFE_CAST(IdDocumento AS INT64) IdDocumento,
SAFE_CAST(IdPauta AS INT64) IdPauta,
SAFE_CAST(IdReuniao AS INT64) IdReuniao,
SAFE_CAST(Deputado AS STRING) Deputado,
SAFE_CAST(TipoVoto AS STRING) TipoVoto
from gabinete-sv.br_sp_alesp_staging.tramitacao_comissoes_permanentes_votacoes as t
