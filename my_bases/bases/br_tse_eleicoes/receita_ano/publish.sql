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

CREATE VIEW gabinete-sv.br_tse_eleicoes.receita_ano AS
SELECT 
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(turno AS INT64) turno,
SAFE_CAST(cargo AS STRING) cargo,
SAFE_CAST(fonte_receita AS STRING) fonte_receita,
SAFE_CAST(origem_receita AS STRING) origem_receita,
SAFE_CAST(descricao_receita AS STRING) descricao_receita,
SAFE_CAST(valor_receita AS FLOAT64) valor_receita
from gabinete-sv.br_tse_eleicoes_staging.receita_ano as t
