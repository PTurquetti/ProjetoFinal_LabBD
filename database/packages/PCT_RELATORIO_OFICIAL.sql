CREATE OR REPLACE PACKAGE PCT_RELATORIO_OFICIAL IS
    FUNCTION GERAR_RELATORIO_HABITANTES(P_CPI_OFICIAL LIDER.CPI%TYPE, P_LINHA_INICIO NUMBER) RETURN VARCHAR2;
END PCT_RELATORIO_OFICIAL;
/


CREATE OR REPLACE PACKAGE BODY PCT_RELATORIO_OFICIAL IS
    FUNCTION GERAR_RELATORIO_HABITANTES(P_CPI_OFICIAL LIDER.CPI%TYPE, P_LINHA_INICIO NUMBER) RETURN VARCHAR2 IS
        V_SAIDA_RELATORIO VARCHAR2(32767);
        V_ATRIBUTOS_LIDER LIDER%ROWTYPE;
        V_NUMERO_LINHA NUMBER := 0;
        V_QTD_LINHAS NUMBER := 0;
        V_BUFFER VARCHAR2(32767);
        V_LIMITE_PAGINA CONSTANT NUMBER := 100;  -- Tamanho máximo de linhas por página
        --V_SAIDA_RELATORIO VARCHAR2(32767) := 'PLANETA;COMUNIDADE;ESPECIE;INICIO_HABITACAO;FIM_HABITACAO' || CHR(10);
    BEGIN
    
        -- Validacao do oficial
        BEGIN
            SELECT * INTO V_ATRIBUTOS_LIDER FROM LIDER WHERE CPI = P_CPI_OFICIAL;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20000, 'Oficial não encontrado.');
        END;

        IF TRIM(V_ATRIBUTOS_LIDER.CARGO) <> 'OFICIAL' THEN
            RAISE_APPLICATION_ERROR(-20000, 'O líder informado não é um oficial.');
        END IF;
        
        
        --cabeçalho do relatório
        IF P_LINHA_INICIO = 1 THEN
            V_SAIDA_RELATORIO := 'PLANETA;COMUNIDADE;ESPECIE;INICIO_HABITACAO;FIM_HABITACAO' || CHR(10);
        ELSE
            V_SAIDA_RELATORIO := '';
        END IF;
        
        
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
                WHERE D.NACAO = (SELECT NACAO FROM LIDER WHERE CPI = P_CPI_OFICIAL)
                ORDER BY PLANETA, COMUNIDADE, ESPECIE, FIM_HABITACAO
                
            ) LOOP
            
               V_NUMERO_LINHA := V_NUMERO_LINHA + 1;
            
            -- Pula as linhas até atingir o início da página desejada
            IF V_NUMERO_LINHA <= P_LINHA_INICIO THEN
                CONTINUE;
            END IF;
               
             -- Constrói a linha do relatório
            V_BUFFER := R.PLANETA || ';' || R.COMUNIDADE || ';' || R.ESPECIE || ';' || R.INICIO_HABITACAO || ';' || R.FIM_HABITACAO || CHR(10);
            
            -- Verifica se excedeu o limite da página
            IF V_QTD_LINHAS >= V_LIMITE_PAGINA THEN
                EXIT; -- Sai do loop se atingir o limite da página
            END IF;

            -- Adiciona a linha ao relatório
            V_SAIDA_RELATORIO := V_SAIDA_RELATORIO || V_BUFFER;
            V_QTD_LINHAS := V_QTD_LINHAS + 1;
            
            END LOOP;
            
            RETURN V_SAIDA_RELATORIO;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'Nenhum dado encontrado';
        WHEN OTHERS THEN
            RETURN 'Erro ao gerar relatório: ' || SQLERRM;

    END GERAR_RELATORIO_HABITANTES;
END PCT_RELATORIO_OFICIAL;
/


/* EXEMPLO - CHAMANDO FUNCAO
DECLARE
    V_CPI_OFICIAL LIDER.CPI%TYPE := '333.333.333-33';  -- Substitua pelo CPI do cientista desejado
    V_LINHA_INICIO NUMBER := 1;  -- Número da linha de início para paginação

    V_RELATORIO VARCHAR2(32767);
BEGIN
    -- Chamada da função do pacote PCT_RELATORIO_CIENTISTA
    V_RELATORIO := PCT_RELATORIO_OFICIAL.GERAR_RELATORIO_HABITANTES(V_CPI_OFICIAL, V_LINHA_INICIO);
    
    -- Exibir o relatório gerado (pode ser substituído por qualquer uso desejado, como salvar em arquivo ou mostrar em um aplicativo)
    DBMS_OUTPUT.PUT_LINE(V_RELATORIO);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao gerar relatório: ' || SQLERRM);
END;

*/

