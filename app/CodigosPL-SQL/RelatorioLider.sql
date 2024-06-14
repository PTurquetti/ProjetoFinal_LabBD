/*
1. Líder de facção:
a. Informações sobre comunidades da própria facção: um líder de facção está
interessado em recuperar informações sobre as comunidades participantes,
facilitando a tomada de decisões de expansão da própria facção.
i. Comunidades podem ser agrupadas por nação, espécie, planeta, e/ou
sistema.
*/

SELECT DISTINCT
    C.NOME AS COMUNIDADE,
    C.ESPECIE AS ESPECIE,
    H.PLANETA AS PLANETA_HABITADO,
    NF.FACCAO AS FACCAO,
    NF.NACAO AS NACAO
    
FROM 
NACAO_FACCAO NF JOIN FACCAO F ON NF.FACCAO = F.NOME
JOIN PARTICIPA P ON F.NOME = P.FACCAO
JOIN COMUNIDADE C ON P.COMUNIDADE = C.NOME AND P.ESPECIE = C.ESPECIE
JOIN HABITACAO H ON C.NOME = H.COMUNIDADE AND C.ESPECIE = H.ESPECIE
ORDER BY COMUNIDADE;