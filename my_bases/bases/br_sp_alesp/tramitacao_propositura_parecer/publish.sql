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
SAFE_CAST(ano_parecer AS STRING) ano_parecer,
SAFE_CAST(descricao AS STRING) descricao,
SAFE_CAST(data AS STRING) data,
SAFE_CAST(ad_referendum AS STRING) ad_referendum,
SAFE_CAST(relator_especial AS STRING) relator_especial,
SAFE_CAST(voto_vencido AS STRING) voto_vencido,
SAFE_CAST(id_comissao AS STRING) id_comissao,
SAFE_CAST(id_documento AS STRING) id_documento,
SAFE_CAST(id_parecer AS STRING) id_parecer,
SAFE_CAST(id_tipo_parecer AS STRING) id_tipo_parecer,
SAFE_CAST(tipo_parecer AS STRING) tipo_parecer,
SAFE_CAST(numero_parecer AS STRING) numero_parecer,
SAFE_CAST(sigla_comissao AS STRING) sigla_comissao,
SAFE_CAST(tipo_parecer1 AS STRING) tipo_parecer1,
SAFE_CAST(url AS STRING) url
from gabinete-sv.br_sp_alesp_staging.tramitacao_propositura_parecer as t