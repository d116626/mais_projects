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

CREATE VIEW gabinete-sv.br_sp_alesp.tramitacao_propositura_parecer AS
SELECT 
SAFE_CAST(AnoParecer AS STRING) AnoParecer,
SAFE_CAST(Descricao AS STRING) Descricao,
SAFE_CAST(Data AS STRING) Data,
SAFE_CAST(AdReferendum AS STRING) AdReferendum,
SAFE_CAST(RelatorEspecial AS STRING) RelatorEspecial,
SAFE_CAST(VotoVencido AS STRING) VotoVencido,
SAFE_CAST(IdComissao AS INT64) IdComissao,
SAFE_CAST(IdDocumento AS INT64) IdDocumento,
SAFE_CAST(IdParecer AS INT64) IdParecer,
SAFE_CAST(IdTipoParecer AS INT64) IdTipoParecer,
SAFE_CAST(TipoParecer AS STRING) TipoParecer,
SAFE_CAST(NrParecer AS STRING) NrParecer,
SAFE_CAST(SiglaComissao AS STRING) SiglaComissao,
SAFE_CAST(TpParecer AS STRING) TpParecer,
SAFE_CAST(URL AS STRING) URL
from gabinete-sv.br_sp_alesp_staging.tramitacao_propositura_parecer as t
