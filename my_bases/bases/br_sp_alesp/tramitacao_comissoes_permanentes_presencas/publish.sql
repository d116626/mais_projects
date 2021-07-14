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

CREATE VIEW gabinete-sv.br_sp_alesp.tramitacao_comissoes_permanentes_presencas AS
SELECT 
SAFE_CAST(data_reuniao AS STRING) data_reuniao,
SAFE_CAST(id_comissao AS STRING) id_comissao,
SAFE_CAST(id_deputado AS STRING) id_deputado,
SAFE_CAST(id_pauta AS STRING) id_pauta,
SAFE_CAST(id_reuniao AS STRING) id_reuniao,
SAFE_CAST(deputado AS STRING) deputado,
SAFE_CAST(sigla_comissao AS STRING) sigla_comissao
from gabinete-sv.br_sp_alesp_staging.tramitacao_comissoes_permanentes_presencas as t