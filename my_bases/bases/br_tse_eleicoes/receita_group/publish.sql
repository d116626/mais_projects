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

CREATE VIEW gabinete-sv.br_tse_eleicoes.receita_group AS
SELECT 
SAFE_CAST(cargo AS STRING) cargo,
SAFE_CAST(valor_receita AS FLOAT64) valor_receita,
SAFE_CAST(nome_urna_candidato AS STRING) nome_urna_candidato,
SAFE_CAST(sigla_partido AS STRING) sigla_partido,
SAFE_CAST(situacao AS STRING) situacao,
SAFE_CAST(ocupacao AS STRING) ocupacao,
SAFE_CAST(idade AS INT64) idade,
SAFE_CAST(genero AS STRING) genero,
SAFE_CAST(estado_civil AS STRING) estado_civil,
SAFE_CAST(raca AS STRING) raca,
SAFE_CAST(resultado AS STRING) resultado,
SAFE_CAST(votos AS INT64) votos,
SAFE_CAST(patrimonio AS FLOAT64) patrimonio,
SAFE_CAST(municipio AS STRING) municipio,
SAFE_CAST(regiao AS STRING) regiao,
SAFE_CAST(mesorregiao AS STRING) mesorregiao,
SAFE_CAST(receita_voto AS FLOAT64) receita_voto,
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(sigla_uf AS STRING) sigla_uf
from gabinete-sv.br_tse_eleicoes_staging.receita_group as t
