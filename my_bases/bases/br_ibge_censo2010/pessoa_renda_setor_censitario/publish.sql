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
    - Para modificar tipos de colunas, basta substituir INT64 por outro tipo válido.
    - Exemplo: `SAFE_CAST(column_name AS NUMERIC) column_name`
    - Mais detalhes: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-types

*/

CREATE VIEW basedosdados.br_ibge_censo2010.pessoa_renda_setor_censitario AS
SELECT 
SAFE_CAST(id_setor_censitario AS INT64) id_setor_censitario,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(v001 AS INT64) v001,
SAFE_CAST(v002 AS INT64) v002,
SAFE_CAST(v003 AS INT64) v003,
SAFE_CAST(v004 AS INT64) v004,
SAFE_CAST(v005 AS INT64) v005,
SAFE_CAST(v006 AS INT64) v006,
SAFE_CAST(v007 AS INT64) v007,
SAFE_CAST(v008 AS INT64) v008,
SAFE_CAST(v009 AS INT64) v009,
SAFE_CAST(v010 AS INT64) v010,
SAFE_CAST(v011 AS INT64) v011,
SAFE_CAST(v012 AS INT64) v012,
SAFE_CAST(v013 AS INT64) v013,
SAFE_CAST(v014 AS INT64) v014,
SAFE_CAST(v015 AS INT64) v015,
SAFE_CAST(v016 AS INT64) v016,
SAFE_CAST(v017 AS INT64) v017,
SAFE_CAST(v018 AS INT64) v018,
SAFE_CAST(v019 AS INT64) v019,
SAFE_CAST(v020 AS INT64) v020,
SAFE_CAST(v021 AS INT64) v021,
SAFE_CAST(v022 AS INT64) v022,
SAFE_CAST(v023 AS INT64) v023,
SAFE_CAST(v024 AS INT64) v024,
SAFE_CAST(v025 AS INT64) v025,
SAFE_CAST(v026 AS INT64) v026,
SAFE_CAST(v027 AS INT64) v027,
SAFE_CAST(v028 AS INT64) v028,
SAFE_CAST(v029 AS INT64) v029,
SAFE_CAST(v030 AS INT64) v030,
SAFE_CAST(v031 AS INT64) v031,
SAFE_CAST(v032 AS INT64) v032,
SAFE_CAST(v033 AS INT64) v033,
SAFE_CAST(v034 AS INT64) v034,
SAFE_CAST(v035 AS INT64) v035,
SAFE_CAST(v036 AS INT64) v036,
SAFE_CAST(v037 AS INT64) v037,
SAFE_CAST(v038 AS INT64) v038,
SAFE_CAST(v039 AS INT64) v039,
SAFE_CAST(v040 AS INT64) v040,
SAFE_CAST(v041 AS INT64) v041,
SAFE_CAST(v042 AS INT64) v042,
SAFE_CAST(v043 AS INT64) v043,
SAFE_CAST(v044 AS INT64) v044,
SAFE_CAST(v045 AS INT64) v045,
SAFE_CAST(v046 AS INT64) v046,
SAFE_CAST(v047 AS INT64) v047,
SAFE_CAST(v048 AS INT64) v048,
SAFE_CAST(v049 AS INT64) v049,
SAFE_CAST(v050 AS INT64) v050,
SAFE_CAST(v051 AS INT64) v051,
SAFE_CAST(v052 AS INT64) v052,
SAFE_CAST(v053 AS INT64) v053,
SAFE_CAST(v054 AS INT64) v054,
SAFE_CAST(v055 AS INT64) v055,
SAFE_CAST(v056 AS INT64) v056,
SAFE_CAST(v057 AS INT64) v057,
SAFE_CAST(v058 AS INT64) v058,
SAFE_CAST(v059 AS INT64) v059,
SAFE_CAST(v060 AS INT64) v060,
SAFE_CAST(v061 AS INT64) v061,
SAFE_CAST(v062 AS INT64) v062,
SAFE_CAST(v063 AS INT64) v063,
SAFE_CAST(v064 AS INT64) v064,
SAFE_CAST(v065 AS INT64) v065,
SAFE_CAST(v066 AS INT64) v066,
SAFE_CAST(v067 AS INT64) v067,
SAFE_CAST(v068 AS INT64) v068,
SAFE_CAST(v069 AS INT64) v069,
SAFE_CAST(v070 AS INT64) v070,
SAFE_CAST(v071 AS INT64) v071,
SAFE_CAST(v072 AS INT64) v072,
SAFE_CAST(v073 AS INT64) v073,
SAFE_CAST(v074 AS INT64) v074,
SAFE_CAST(v075 AS INT64) v075,
SAFE_CAST(v076 AS INT64) v076,
SAFE_CAST(v077 AS INT64) v077,
SAFE_CAST(v078 AS INT64) v078,
SAFE_CAST(v079 AS INT64) v079,
SAFE_CAST(v080 AS INT64) v080,
SAFE_CAST(v081 AS INT64) v081,
SAFE_CAST(v082 AS INT64) v082,
SAFE_CAST(v083 AS INT64) v083,
SAFE_CAST(v084 AS INT64) v084,
SAFE_CAST(v085 AS INT64) v085,
SAFE_CAST(v086 AS INT64) v086,
SAFE_CAST(v087 AS INT64) v087,
SAFE_CAST(v088 AS INT64) v088,
SAFE_CAST(v089 AS INT64) v089,
SAFE_CAST(v090 AS INT64) v090,
SAFE_CAST(v091 AS INT64) v091,
SAFE_CAST(v092 AS INT64) v092,
SAFE_CAST(v093 AS INT64) v093,
SAFE_CAST(v094 AS INT64) v094,
SAFE_CAST(v095 AS INT64) v095,
SAFE_CAST(v096 AS INT64) v096,
SAFE_CAST(v097 AS INT64) v097,
SAFE_CAST(v098 AS INT64) v098,
SAFE_CAST(v099 AS INT64) v099,
SAFE_CAST(v100 AS INT64) v100,
SAFE_CAST(v101 AS INT64) v101,
SAFE_CAST(v102 AS INT64) v102,
SAFE_CAST(v103 AS INT64) v103,
SAFE_CAST(v104 AS INT64) v104,
SAFE_CAST(v105 AS INT64) v105,
SAFE_CAST(v106 AS INT64) v106,
SAFE_CAST(v107 AS INT64) v107,
SAFE_CAST(v108 AS INT64) v108,
SAFE_CAST(v109 AS INT64) v109,
SAFE_CAST(v110 AS INT64) v110,
SAFE_CAST(v111 AS INT64) v111,
SAFE_CAST(v112 AS INT64) v112,
SAFE_CAST(v113 AS INT64) v113,
SAFE_CAST(v114 AS INT64) v114,
SAFE_CAST(v115 AS INT64) v115,
SAFE_CAST(v116 AS INT64) v116,
SAFE_CAST(v117 AS INT64) v117,
SAFE_CAST(v118 AS INT64) v118,
SAFE_CAST(v119 AS INT64) v119,
SAFE_CAST(v120 AS INT64) v120,
SAFE_CAST(v121 AS INT64) v121,
SAFE_CAST(v122 AS INT64) v122,
SAFE_CAST(v123 AS INT64) v123,
SAFE_CAST(v124 AS INT64) v124,
SAFE_CAST(v125 AS INT64) v125,
SAFE_CAST(v126 AS INT64) v126,
SAFE_CAST(v127 AS INT64) v127,
SAFE_CAST(v128 AS INT64) v128,
SAFE_CAST(v129 AS INT64) v129,
SAFE_CAST(v130 AS INT64) v130,
SAFE_CAST(v131 AS INT64) v131,
SAFE_CAST(v132 AS INT64) v132
from basedosdados-staging.br_ibge_censo2010_staging.pessoa_renda_setor_censitario as t