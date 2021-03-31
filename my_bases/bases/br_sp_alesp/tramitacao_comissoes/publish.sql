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

CREATE VIEW gabinete-sv.br_sp_alesp.tramitacao_comissoes AS
SELECT 
SAFE_CAST(data_fim_comissao AS STRING) data_fim_comissao,
SAFE_CAST(id_comissao AS STRING) id_comissao,
SAFE_CAST(nome_comissao AS STRING) nome_comissao,
SAFE_CAST(sigla_comissao AS STRING) sigla_comissao
from gabinete-sv.br_sp_alesp_staging.tramitacao_comissoes as t