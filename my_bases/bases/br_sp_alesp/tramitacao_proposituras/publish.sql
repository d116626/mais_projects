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
SAFE_CAST(AnoLegislativo AS STRING) AnoLegislativo,
SAFE_CAST(CodOriginalidade AS STRING) CodOriginalidade,
SAFE_CAST(Ementa AS STRING) Ementa,
SAFE_CAST(DtEntradaSistema AS STRING) DtEntradaSistema,
SAFE_CAST(DtPublicacao AS STRING) DtPublicacao,
SAFE_CAST(IdDocumento AS INT64) IdDocumento,
SAFE_CAST(IdNatureza AS INT64) IdNatureza,
SAFE_CAST(NroLegislativo AS STRING) NroLegislativo
from gabinete-sv.br_sp_alesp_staging.tramitacao_proposituras as t
