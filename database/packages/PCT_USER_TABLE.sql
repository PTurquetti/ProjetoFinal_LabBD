-- Declaração de pacote para manipulações de usuário
CREATE OR REPLACE PACKAGE PCT_USER_TABLE AS
    E_ERRO_NA_CRIPTOGRAFIA EXCEPTION;
    E_ERRO_NO_LOG EXCEPTION;
    FUNCTION calcular_md5( -- criptografar senha
        p_string VARCHAR2
    ) RETURN VARCHAR2;
    FUNCTION fazer_login( --retorna se senha está correta cargo do lider e insere login na tabel de log
        p_idlider LIDER.CPI%tYPE,
        p_password VARCHAR2
    ) RETURN VARCHAR2;
    PROCEDURE inserir_log( -- insere na tabela de log
        p_idlider LOG_TABLE.USERID%TYPE,
        p_message LOG_TABLE.MESSAGE%TYPE
    );
END PCT_USER_TABLE;

/

-- Corpo do pacote utilitário
CREATE OR REPLACE PACKAGE BODY PCT_USER_TABLE AS
    FUNCTION calcular_md5( --criptografar senha
        p_string VARCHAR2
    ) RETURN VARCHAR2 AS
        v_raw RAW(32);
        v_md5 RAW(32);
    BEGIN
        v_raw := utl_raw.cast_to_raw(p_string);
        DBMS_OBFUSCATION_TOOLKIT.md5(input => v_raw, checksum => v_md5);
        RETURN RAWTOHEX(v_md5);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE E_ERRO_NA_CRIPTOGRAFIA;
    END calcular_md5;

    FUNCTION fazer_login( --faz login
        p_idlider LIDER.CPI%tYPE,
        p_password VARCHAR2
    ) RETURN VARCHAR2 AS
        v_stored_password VARCHAR2(32);
        v_input_password_hash VARCHAR2(32);
        v_cargo CHAR(10);
        v_userid USERS.USERID%TYPE;
    BEGIN
        -- Calcule o hash MD5 da senha fornecida pelo usuário usando a função calcular_md5
        v_input_password_hash := PCT_USER_TABLE.calcular_md5(p_password);
        
        BEGIN
            -- Obtenha a senha criptografada e o id do user
            SELECT password, userid INTO v_stored_password, v_userid FROM users WHERE idlider = p_idlider;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'Usuário não cadastrado';
        END;

        -- Compare os hashes e retorne o resultado
        IF v_stored_password = v_input_password_hash THEN
            BEGIN
                SELECT cargo INTO v_cargo FROM lider WHERE CPI = p_idlider;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RETURN 'Cargo não encontrado para o líder.';
            END;
            -- Insere o log
            PCT_USER_TABLE.INSERIR_LOG(v_userid, 'LOGIN');
            -- Retorna resultado
            RETURN 'Senha correta. Id: ' || v_userid || '. Cargo: ' || v_cargo || '.';
        END IF;
        RETURN 'Senha incorreta';
    END fazer_login;
    PROCEDURE inserir_log( -- insere na tabela de log
        p_idlider LOG_TABLE.USERID%TYPE,
        p_message LOG_TABLE.MESSAGE%TYPE
    ) AS
    BEGIN
        INSERT INTO LOG_TABLE (USERID, MESSAGE) VALUES (p_idlider, p_message);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE E_ERRO_NO_LOG;
    END inserir_log;
    
END PCT_USER_TABLE;
/
