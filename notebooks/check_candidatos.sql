ano     id_municipio       check
2016    2701506            
2016    2706406            
2016    2313401            
2016    5204656            
2016    2110401            
2016    5100607            
2016    3305802            
2016    2400901            
2016    2404507            
2016    3519303            
2016    3523008            
2016    3524006            
2016    3527108            
2016    3533403            
2020    2922755            
2020    2314102            
2020    3147600            
2020    4128559            
2020    4302105            
2020    4317707            
2020    2807006            
2020    3517406            
2020    3519253            




-- SELECT 
--   t1.*
-- FROM basedosdados.br_tse_eleicoes.candidatos  t1
-- WHERE (t1.ano=2016) 
--   AND (t1.cargo='prefeito')
--   AND t1.id_municipio = '3527108'


SELECT
  t1.ano,
  t1.cargo,
  IFNULL(t2.genero,"nao declarado") as genero,
  IFNULL(t2.raca,"nao declarado") as raca,
  REPLACE(
    REPLACE(t1.resultado,r"por qp", "" ), 
    r"por media", "") as resultado,
  SUM(1) as eleitos,
  SUM(t1.votos) as votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato` t1
JOIN `basedosdados.br_tse_eleicoes.candidatos` t2
ON t1.ano=t2.ano 
  AND t1.tipo_eleicao = t2.tipo_eleicao 
  AND t1.sigla_uf =t2.sigla_uf 
  AND t1.numero_candidato = t2.numero 
  AND t1.cargo =t2.cargo 
  AND t1.id_municipio =t2.id_municipio 
WHERE (t2.ano=2016 ) 
  AND (t1.cargo='prefeito')
  AND (t1.resultado LIKE '%eleito%' and t1.resultado != 'nao eleito')
  AND t1.tipo_eleicao = "eleicao ordinaria"
  AND ( t2.situacao LIKE '%deferido%' OR 
       t2.situacao = 'cassado'
  )
  AND t2.situacao != 'indeferido'
  AND t2.id_municipio = '3527108'
GROUP BY 1,2,3,4,5
ORDER BY 1,2,3,4