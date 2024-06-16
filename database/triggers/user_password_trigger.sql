-- Função para calcular o hash MD5 usando DBMS_OBFUSCATION_TOOLKIT
CREATE OR REPLACE FUNCTION calcular_md5(p_string IN VARCHAR2) RETURN VARCHAR2 IS
    v_raw RAW(32);
    v_md5 RAW(32);
BEGIN
    v_raw := utl_raw.cast_to_raw(p_string);
    DBMS_OBFUSCATION_TOOLKIT.md5(input => v_raw, checksum => v_md5);
    RETURN RAWTOHEX(v_md5);
END;
/

-- Criação do trigger para aplicar MD5 na senha
CREATE OR REPLACE TRIGGER trg_users_password
BEFORE INSERT OR UPDATE ON users
FOR EACH ROW
BEGIN
    -- Aplica MD5 no campo password usando a função calcular_md5
    :NEW.password := calcular_md5(:NEW.password);
END;
/
