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

CREATE VIEW gabinete-sv.br_sp_alesp.deputados AS
SELECT 
SAFE_CAST(idDeputado AS INT64) idDeputado,
SAFE_CAST(nomeParlamentar AS STRING) nomeParlamentar,
SAFE_CAST(aniversario AS STRING) aniversario,
SAFE_CAST(partido AS STRING) partido,
SAFE_CAST(situacao AS STRING) situacao,
SAFE_CAST(email AS STRING) email,
SAFE_CAST(sala AS STRING) sala,
SAFE_CAST(placaVeiculo AS STRING) placaVeiculo,
SAFE_CAST(homePage AS STRING) homePage,
SAFE_CAST(andar AS STRING) andar,
SAFE_CAST(matricula AS STRING) matricula,
SAFE_CAST(IdSPL AS STRING) IdSPL,
SAFE_CAST(numero_deputados AS INT64) numero_deputados
from gabinete-sv.br_sp_alesp_staging.deputados as t
