/*
1. Líder de facção:
a. Informações sobre comunidades da própria facção: um líder de facção está
interessado em recuperar informações sobre as comunidades participantes,
facilitando a tomada de decisões de expansão da própria facção.
i. Comunidades podem ser agrupadas por nação, espécie, planeta, e/ou
sistema.
*/


CREATE OR REPLACE PROCEDURE GERAR_RELATORIO_COMUNIDADES (V_LIDER LIDER.CPI%TYPE) AS

    CURSOR C_INFOS_COMUNIDADE IS
        SELECT DISTINCT
            C.NOME AS COMUNIDADE,
            C.ESPECIE AS ESPECIE,
            H.PLANETA AS PLANETA_HABITADO,
            NF.FACCAO AS FACCAO,
            NF.NACAO AS NACAO
        FROM 
            NACAO_FACCAO NF 
            JOIN FACCAO F ON NF.FACCAO = F.NOME
            JOIN LIDER L ON F.LIDER = L.CPI
            JOIN PARTICIPA P ON F.NOME = P.FACCAO
            JOIN COMUNIDADE C ON P.COMUNIDADE = C.NOME AND P.ESPECIE = C.ESPECIE
            JOIN HABITACAO H ON C.NOME = H.COMUNIDADE AND C.ESPECIE = H.ESPECIE
        WHERE 
            L.CPI = V_LIDER
        ORDER BY 
            C.NOME;
            
    V_COMUNIDADE COMUNIDADE.NOME%TYPE;
    V_ESPECIE COMUNIDADE.ESPECIE%TYPE;
    V_PLANETA HABITACAO.PLANETA%TYPE;
    V_FACCAO NACAO_FACCAO.FACCAO%TYPE;
    V_NACAO NACAO_FACCAO.NACAO%TYPE;
    
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('COMUNIDADE | ESPECIE | PLANETA_HABITADO | FACCAO | NACAO');
    DBMS_OUTPUT.PUT_LINE('-----------|--------|------------------|--------|------');
    
    OPEN C_INFOS_COMUNIDADE;
    
    LOOP
        FETCH C_INFOS_COMUNIDADE INTO V_COMUNIDADE, V_ESPECIE, V_PLANETA, V_FACCAO, V_NACAO;
        EXIT WHEN C_INFOS_COMUNIDADE%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(V_COMUNIDADE || ' | ' 
                            || V_ESPECIE || ' | '
                            || V_PLANETA || ' | '
                            || V_FACCAO || ' | '
                            || V_NACAO);
    END LOOP;
    
    CLOSE C_INFOS_COMUNIDADE;
    
END;


-- Exemplo de chamada da procedure

DECLARE
    V_LIDER LIDER.CPI%TYPE := '111.111.111-11';
BEGIN
    GERAR_RELATORIO_COMUNIDADES(V_LIDER);
END;




