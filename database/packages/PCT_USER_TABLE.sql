-- Declaração de pacote para manipulações de usuário
CREATE OR REPLACE PACKAGE PCT_USER_TABLE AS
    E_ERRO_NA_CRIPTOGRAFIA EXCEPTION;
    E_ERRO_NO_LOG EXCEPTION;

    FUNCTION CALCULAR_MD5( -- criptografar senha
        P_STRING VARCHAR2
    ) RETURN VARCHAR2;

    FUNCTION FAZER_LOGIN( -- se senha estiver correta, retorna informações do lider e insere login na tabel de log
        P_IDLIDER LIDER.CPI%TYPE,
        P_PASSWORD VARCHAR2
    ) RETURN VARCHAR2;

    PROCEDURE INSERIR_LOG( -- insere na tabela de log
        P_IDLIDER LOG_TABLE.USERID%TYPE,
        P_MESSAGE LOG_TABLE.MESSAGE%TYPE
    );
END PCT_USER_TABLE;

/

-- Corpo do pacote para manipulações de usuário
CREATE OR REPLACE PACKAGE BODY PCT_USER_TABLE AS
    FUNCTION CALCULAR_MD5( --criptografar senha
        P_STRING VARCHAR2
    ) RETURN VARCHAR2 AS
        V_RAW RAW(32);
        V_MD5 RAW(32);
    BEGIN
        V_RAW := UTL_RAW.CAST_TO_RAW(P_STRING);
        DBMS_OBFUSCATION_TOOLKIT.MD5(INPUT => V_RAW, CHECKSUM => V_MD5);
        RETURN RAWTOHEX(V_MD5);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE E_ERRO_NA_CRIPTOGRAFIA;
    END CALCULAR_MD5;

    FUNCTION FAZER_LOGIN( --faz login
        P_IDLIDER LIDER.CPI%TYPE,
        P_PASSWORD VARCHAR2
    ) RETURN VARCHAR2 AS
        V_INPUT_PASSWORD_HASH VARCHAR2(32);
        V_LINHA_USER_LIDER VIEW_USUARIO_LIDER%ROWTYPE;
    BEGIN
        -- Calcule o hash MD5 da senha fornecida pelo usuário usando a função calcular_md5
        V_INPUT_PASSWORD_HASH := PCT_USER_TABLE.CALCULAR_MD5(P_PASSWORD);
        
        BEGIN
            -- Obtenha a senha criptografada e o id do user
            SELECT * INTO V_LINHA_USER_LIDER FROM VIEW_USUARIO_LIDER WHERE CPI = P_IDLIDER;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20000, 'Usuário não cadastrado');
        END;

        -- Compare os hashes e retorne o resultado
        -- IF V_STORED_PASSWORD = V_INPUT_PASSWORD_HASH THEN
        IF V_LINHA_USER_LIDER.PASSWORD = V_INPUT_PASSWORD_HASH THEN
            -- Retorna resultado
            RETURN V_LINHA_USER_LIDER.ID || ';' || 
                     V_LINHA_USER_LIDER.NOME || ';' || 
                     V_LINHA_USER_LIDER.CARGO || ';' || 
                     V_LINHA_USER_LIDER.NACAO || ';' ||
                     V_LINHA_USER_LIDER.NOME_FACCAO;
        END IF;
        RAISE_APPLICATION_ERROR(-20000, 'Senha incorreta');
    END FAZER_LOGIN;

    PROCEDURE INSERIR_LOG( -- insere na tabela de log
        P_IDLIDER LOG_TABLE.USERID%TYPE,
        P_MESSAGE LOG_TABLE.MESSAGE%TYPE
    ) AS
    BEGIN
        INSERT INTO LOG_TABLE (USERID, MESSAGE) VALUES (P_IDLIDER, P_MESSAGE);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE E_ERRO_NO_LOG;
    END INSERIR_LOG;
    
END PCT_USER_TABLE;
/
