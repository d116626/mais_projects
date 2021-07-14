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

CREATE VIEW gabinete-sv.br_tse_eleicoes.locais_votacao AS
SELECT 
SAFE_CAST(sgl_uf AS STRING) sgl_uf,
SAFE_CAST(id_municipio AS INT64) id_municipio,
SAFE_CAST(localidade_local_votacao AS INT64) localidade_local_votacao,
SAFE_CAST(zona AS INT64) zona,
SAFE_CAST(bairro_zona_sede AS STRING) bairro_zona_sede,
SAFE_CAST(latitude_zona AS STRING) latitude_zona,
SAFE_CAST(longitude_zona AS STRING) longitude_zona,
SAFE_CAST(num_local AS INT64) num_local,
SAFE_CAST(situacao_local AS STRING) situacao_local,
SAFE_CAST(tipo_local AS STRING) tipo_local,
SAFE_CAST(local_votacao AS STRING) local_votacao,
SAFE_CAST(endereco AS STRING) endereco,
SAFE_CAST(bairro_local_vot AS STRING) bairro_local_vot,
SAFE_CAST(cep AS STRING) cep,
SAFE_CAST(latitude_local AS STRING) latitude_local,
SAFE_CAST(longitude_local AS STRING) longitude_local,
SAFE_CAST(secao AS INT64) secao,
SAFE_CAST(secao_agregadora AS STRING) secao_agregadora,
SAFE_CAST(secao_agregada AS STRING) secao_agregada
from gabinete-sv.br_tse_eleicoes_staging.locais_votacao as t
