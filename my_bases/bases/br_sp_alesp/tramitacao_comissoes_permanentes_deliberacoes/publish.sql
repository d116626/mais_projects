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

CREATE VIEW gabinete-sv.br_sp_alesp.tramitacao_comissoes_permanentes_deliberacoes AS
SELECT 
SAFE_CAST(deliberacao AS STRING) deliberacao,
SAFE_CAST(data_inclusao AS STRING) data_inclusao,
SAFE_CAST(data_saida AS STRING) data_saida,
SAFE_CAST(id_deliberacao AS STRING) id_deliberacao,
SAFE_CAST(id_documento AS STRING) id_documento,
SAFE_CAST(id_pauta AS STRING) id_pauta,
SAFE_CAST(id_reuniao AS STRING) id_reuniao,
SAFE_CAST(nuumero_ordem AS STRING) nuumero_ordem
from gabinete-sv.br_sp_alesp_staging.tramitacao_comissoes_permanentes_deliberacoes as t