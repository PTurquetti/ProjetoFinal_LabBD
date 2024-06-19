CREATE OR REPLACE PACKAGE PCT_RELATORIO_OFICIAL IS
    FUNCTION GERAR_RELATORIO_HABITANTES(V_LIDER LIDER.CPI%TYPE) RETURN VARCHAR2;
END PCT_RELATORIO_OFICIAL;
/

CREATE OR REPLACE PACKAGE BODY PCT_RELATORIO_OFICIAL IS
    FUNCTION GERAR_RELATORIO_HABITANTES(V_LIDER LIDER.CPI%TYPE) RETURN VARCHAR2 IS
        V_SAIDA_RELATORIO VARCHAR2(32767) := 'PLANETA;COMUNIDADE;ESPECIE;INICIO_HABITACAO;FIM_HABITACAO' || CHR(10);
    BEGIN
        BEGIN
            FOR R IN (
                SELECT DISTINCT
                    D.PLANETA AS PLANETA,
                    H.COMUNIDADE AS COMUNIDADE,
                    H.ESPECIE AS ESPECIE,
                    H.DATA_INI AS INICIO_HABITACAO,
                    H.DATA_FIM AS FIM_HABITACAO
                FROM
                    DOMINANCIA D
                    LEFT JOIN HABITACAO H ON H.PLANETA = D.PLANETA
                    JOIN COMUNIDADE C ON C.ESPECIE = H.ESPECIE AND C.NOME = H.COMUNIDADE
                WHERE D.NACAO = (SELECT NACAO FROM LIDER WHERE CPI = V_LIDER)
                ORDER BY PLANETA, COMUNIDADE, ESPECIE, FIM_HABITACAO DESC
            ) LOOP
                V_SAIDA_RELATORIO := V_SAIDA_RELATORIO || R.PLANETA || ';' || R.COMUNIDADE || ';' 
                                    || R.ESPECIE || ';' || R.INICIO_HABITACAO || ';' || R.FIM_HABITACAO || CHR(10);
            END LOOP;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_SAIDA_RELATORIO := 'Nenhum dado encontrado';
            WHEN OTHERS THEN
                V_SAIDA_RELATORIO := 'Erro ao gerar relatorio';
        END;

        RETURN V_SAIDA_RELATORIO;
    END GERAR_RELATORIO_HABITANTES;
END PCT_RELATORIO_OFICIAL;
