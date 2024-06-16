-- Declaração de pacote utilitário
CREATE OR REPLACE PACKAGE PCT_USER_TABLE AS
    E_ERRO_NA_CRIPTOGRAFIA EXCEPTION;
    FUNCTION calcular_md5( --criptografar senha
        p_string VARCHAR2
    ) RETURN VARCHAR2;
    FUNCTION verificar_senha( -- retorna se senha está correta cargo do lider
        p_idlider LIDER.CPI%tYPE,
        p_password VARCHAR2
    ) RETURN VARCHAR2;
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

    FUNCTION verificar_senha(
        p_idlider LIDER.CPI%tYPE,
        p_password VARCHAR2
    ) RETURN VARCHAR2 IS
        v_stored_password VARCHAR2(32);
        v_input_password_hash VARCHAR2(32);
        v_cargo CHAR(10);
    BEGIN
        -- Calcule o hash MD5 da senha fornecida pelo usuário usando a função calcular_md5
        v_input_password_hash := PCT_USER_TABLE.calcular_md5(p_password);
        
        BEGIN
            -- Obtenha o hash armazenado no banco de dados
            SELECT password INTO v_stored_password FROM users WHERE idlider = p_idlider;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'Usuário não cadastrado na tabela user';
        END;

        -- Compare os hashes e retorne o resultado
        IF v_stored_password = v_input_password_hash THEN
            BEGIN
                SELECT cargo INTO v_cargo FROM lider WHERE CPI = p_idlider;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RETURN 'Cargo não encontrado para o líder.';
            END;
            RETURN 'Senha correta. Cargo: ' || v_cargo || '.';
        ELSE
            RETURN 'Senha incorreta';
        END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'Usuário não cadastrado na tabela lider';
    END verificar_senha;

END PCT_USER_TABLE;
/
