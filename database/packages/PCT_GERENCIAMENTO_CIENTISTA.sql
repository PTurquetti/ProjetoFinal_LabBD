-- Declaração de pacote para manipulações de usuário
CREATE OR REPLACE PACKAGE PCT_GERENCIAMENTO_CIENTISTA AS
    E_USER_NAO_CADASTRADO EXCEPTION;
    E_NAO_EH_CIENTISTA EXCEPTION;
    --E_ESTRELA_INVALIDA EXCEPTION;
    --E_ESTRELA_NAO_EXISTE EXCEPTION;
    FUNCTION insere_estrela (
        p_cpi LIDER.CPI%TYPE,
        p_id ESTRELA.ID_ESTRELA%TYPE,
        p_nome ESTRELA.NOME%TYPE,
        p_classificacao ESTRELA.CLASSIFICACAO%TYPE,
        p_massa ESTRELA.MASSA%TYPE,
        p_x ESTRELA.X%TYPE,
        p_y ESTRELA.Y%TYPE,
        p_z ESTRELA.Z%TYPE
    ) RETURN VARCHAR2;
    FUNCTION remove_estrela_por_id (
        p_cpi LIDER.CPI%TYPE,
        p_id ESTRELA.ID_ESTRELA%TYPE
    ) RETURN VARCHAR2;
    /*FUNCTION remove_estrela_por_posicao (
        p_cpi LIDER.CPI%TYPE,
        p_x ESTRELA.X%TYPE,
        p_y ESTRELA.Y%TYPE,
        p_z ESTRELA.Z%TYPE
    ) RETURN VARCHAR2;
    FUNCTION ler_estrela_por_id (
        p_cpi LIDER.CPI%TYPE,
        p_id ESTRELA.ID_ESTRELA%TYPE
    ) RETURN VARCHAR2;
    FUNCTION ler_estrela_por_posicao (
        p_cpi LIDER.CPI%TYPE,
        p_x ESTRELA.X%TYPE,
        p_y ESTRELA.Y%TYPE,
        p_z ESTRELA.Z%TYPE
    ) RETURN VARCHAR2;
    FUNCTION update_estrela (
        p_cpi LIDER.CPI%TYPE,
        p_id_antigo ESTRELA.ID_ESTRELA%TYPE,
        p_id ESTRELA.ID_ESTRELA%TYPE,
        p_nome ESTRELA.NOME%TYPE,
        p_classificacao ESTRELA.CLASSIFICACAO%TYPE,
        p_massa ESTRELA.MASSA%TYPE,
        p_x ESTRELA.X%TYPE,
        p_y ESTRELA.Y%TYPE,
        p_z ESTRELA.Z%TYPE
    ) RETURN VARCHAR2;*/
END PCT_GERENCIAMENTO_CIENTISTA;

/

-- Corpo do pacote utilitário
CREATE OR REPLACE PACKAGE BODY PCT_GERENCIAMENTO_CIENTISTA AS
    FUNCTION retorna_se_cientista(
        p_cpiuser LIDER.CPI%TYPE
    ) RETURN BOOLEAN IS
        v_cargo LIDER.CARGO%TYPE;
        v_saida BOOLEAN;
    BEGIN
        SELECT cargo INTO v_cargo FROM lider WHERE CPI =  p_cpiuser;
        IF UPPER(TRIM(v_cargo)) = 'CIENTISTA' THEN
            RETURN TRUE;
        END IF;
        RETURN FALSE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END retorna_se_cientista;

    FUNCTION insere_estrela (
        p_cpi LIDER.CPI%TYPE,
        p_id ESTRELA.ID_ESTRELA%TYPE,
        p_nome ESTRELA.NOME%TYPE,
        p_classificacao ESTRELA.CLASSIFICACAO%TYPE,
        p_massa ESTRELA.MASSA%TYPE,
        p_x ESTRELA.X%TYPE,
        p_y ESTRELA.Y%TYPE,
        p_z ESTRELA.Z%TYPE
    ) RETURN VARCHAR2 IS
    BEGIN
        IF (NOT retorna_se_cientista(p_cpi)) THEN
            RAISE E_NAO_EH_CIENTISTA;
        END IF;
        INSERT INTO ESTRELA VALUES (p_id, p_nome, p_classificacao, p_massa, p_x, p_y, p_z);
        RETURN 'Estrela inserida com sucesso.';
    EXCEPTION
        WHEN E_USER_NAO_CADASTRADO THEN
            RAISE_APPLICATION_ERROR(-20000, 'Usuário não cadastrado');
        WHEN E_NAO_EH_CIENTISTA THEN
            RAISE_APPLICATION_ERROR(-20000, 'Usuário não é cientista');
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Já existe estrela nessa posição ou com esse ID');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000, 'Não foi possível inserir estrela.');
    END insere_estrela;

    FUNCTION remove_estrela_por_id (
        p_cpi LIDER.CPI%TYPE,
        p_id ESTRELA.ID_ESTRELA%TYPE
    ) RETURN VARCHAR2 IS
        v_estrela ESTRELA.ID_ESTRELA%TYPE;
    BEGIN
        IF (NOT retorna_se_cientista(p_cpi)) THEN
            RAISE E_NAO_EH_CIENTISTA;
        END IF;
        SELECT ID_ESTRELA INTO v_estrela FROM ESTRELA WHERE ID_ESTRELA = p_id;
        DELETE FROM ESTRELA WHERE ID_ESTRELA = p_id;
        RETURN 'Estrela removida com sucesso.';
    EXCEPTION
        WHEN E_USER_NAO_CADASTRADO THEN
            RAISE_APPLICATION_ERROR(-20000, 'Usuário não cadastrado');
        WHEN E_NAO_EH_CIENTISTA THEN
            RAISE_APPLICATION_ERROR(-20000, 'Usuário não é cientista');
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000, 'Estrela com esse id não existe');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000, 'Não foi possível inserir estrela.');
    END remove_estrela_por_id;
    
END PCT_GERENCIAMENTO_CIENTISTA;
/
