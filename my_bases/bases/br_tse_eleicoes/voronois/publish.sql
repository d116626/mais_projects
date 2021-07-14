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

CREATE VIEW gabinete-sv.br_tse_eleicoes.voronois AS
SELECT 
SAFE_CAST(index AS INT64) index,
SAFE_CAST(id_unico AS INT64) id_unico,
SAFE_CAST(loc_unico AS INT64) loc_unico,
SAFE_CAST(lat AS STRING) lat,
SAFE_CAST(lon AS STRING) lon,
SAFE_CAST(fetched_ad AS STRING) fetched_ad,
SAFE_CAST(precision AS STRING) precision,
SAFE_CAST(local_vota AS STRING) local_vota,
SAFE_CAST(endereco AS STRING) endereco,
SAFE_CAST(cep AS STRING) cep,
SAFE_CAST(id_municipio AS INT64) id_municipio,
SAFE_CAST(localidade AS STRING) localidade,
SAFE_CAST(sgl_uf AS STRING) sgl_uf,
SAFE_CAST(zona AS INT64) zona,
SAFE_CAST(bairro_zon AS STRING) bairro_zon,
SAFE_CAST(latitude_z AS STRING) latitude_z,
SAFE_CAST(longitude_ AS STRING) longitude_,
SAFE_CAST(num_secao AS INT64) num_secao,
SAFE_CAST(num_local AS INT64) num_local,
SAFE_CAST(bairro_loc AS STRING) bairro_loc,
SAFE_CAST(country AS STRING) country,
SAFE_CAST(geom_str AS STRING) geom_str,
SAFE_CAST(index_righ AS STRING) index_righ,
SAFE_CAST(nm_municip AS STRING) nm_municip,
SAFE_CAST(cd_geocmu AS STRING) cd_geocmu,
SAFE_CAST(uf AS STRING) uf,
SAFE_CAST(cdo_tse AS STRING) cdo_tse,
SAFE_CAST(cod_ibge AS STRING) cod_ibge,
SAFE_CAST(geometry AS STRING) geometry
from gabinete-sv.br_tse_eleicoes_staging.voronois as t
