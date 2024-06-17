-- Declaração de pacote para manipulações de usuário
CREATE OR REPLACE PACKAGE PCT_GERENCIAMENTO_LIDER AS
    E_USER_NAO_EH_LIDER EXCEPTION;
    E_LIDER_JA_EH_LIDER_DE_OUTRA_FACCAO EXCEPTION;
    /*E_COMUNIDADE_JA_PARTICIPA EXCEPTION;
    E_COMUNIDADE_INVALIDA EXCEPTION;
    E_FACCAO_NAO_PERTENCE_A_NACAO EXCEPTION;*/
    FUNCTION alterar_nome_faccao (
        p_cpilider LIDER.CPI%TYPE,
        p_novo_nome FACCAO.NOME%TYPE
    ) RETURN VARCHAR2;
    FUNCTION indica_lider (
        p_cpilider LIDER.CPI%TYPE,
        p_cpi_novo_lider LIDER.CPI%TYPE
    ) RETURN VARCHAR2;
    /*FUNCTION credenciar_comunidade (
        p_cpilider LIDER.CPI%TYPE,
        p_especie_comunidade COMUNIDADE.NOME%TYPE, 
        p_nome_comunidade COMUNIDADE.NOME%TYPE
    ) RETURN VARCHAR2;
    FUNCTION remove_faccao_de_nacao (
        p_cpilider LIDER.CPI%TYPE,
        p_nacao NACAO.NOME%TYPE
    ) RETURN VARCHAR2;*/
END PCT_GERENCIAMENTO_LIDER;

/

-- Corpo do pacote utilitário
CREATE OR REPLACE PACKAGE BODY PCT_GERENCIAMENTO_LIDER AS
    FUNCTION retorna_faccao(
        p_cpilider LIDER.CPI%TYPE
    ) RETURN FACCAO.NOME%TYPE IS
        v_faccao FACCAO.NOME%TYPE;
    BEGIN
        SELECT nome INTO v_faccao FROM FACCAO WHERE LIDER =  p_cpilider;
        RETURN v_faccao;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN null;
    END retorna_faccao;

    FUNCTION alterar_nome_faccao (
        p_cpilider LIDER.CPI%TYPE,
        p_novo_nome FACCAO.NOME%TYPE
    ) RETURN VARCHAR2 IS
        v_faccao FACCAO.NOME%TYPE; -- Facção do líder
    BEGIN
        v_faccao := retorna_faccao(p_cpilider); -- Retorna a facção do líder
        IF v_faccao is null THEN
            RAISE E_USER_NAO_EH_LIDER; -- Usuário não é líder de nenhuma facção
        END IF;
        UPDATE FACCAO SET NOME = p_novo_nome WHERE NOME = v_faccao; -- Update no nome
        -- Esse update aciona o trigger de update de nome de facção, pois existem tabelas que precisam ser alteradas também.
        RETURN 'Nome alterado com sucesso!';
    EXCEPTION
        WHEN E_USER_NAO_EH_LIDER THEN
            RAISE_APPLICATION_ERROR(-20000, 'Usuário não é líder de nenhuma facção.');
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Já existe uma facção com esse nome.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000, 'Não foi possível mudar o nome da facção.');
    END alterar_nome_faccao;

    FUNCTION indica_lider (
        p_cpilider LIDER.CPI%TYPE,
        p_cpi_novo_lider LIDER.CPI%TYPE
    ) RETURN VARCHAR2 IS
        v_faccao_lider FACCAO.NOME%TYPE;
        v_faccao_outro_lider FACCAO.NOME%TYPE;
    BEGIN
        v_faccao_lider := retorna_faccao(p_cpilider);
        v_faccao_outro_lider := retorna_faccao(p_cpi_novo_lider);
        IF v_faccao_lider IS NULL THEN
            RAISE E_USER_NAO_EH_LIDER;
        END IF;
        IF v_faccao_outro_lider IS NOT NULL THEN
            RAISE E_LIDER_JA_EH_LIDER_DE_OUTRA_FACCAO;
        END IF;
        UPDATE FACCAO SET LIDER = p_cpi_novo_lider WHERE LIDER = p_cpilider;
        RETURN 'Líder alterado com sucesso!';
        EXCEPTION
            WHEN E_USER_NAO_EH_LIDER THEN
                RAISE_APPLICATION_ERROR(-20000, 'Usuário não é líder de nenhuma facção.');
            WHEN E_LIDER_JA_EH_LIDER_DE_OUTRA_FACCAO THEN
                RAISE_APPLICATION_ERROR(-20000, 'Líder indicado já é líder de outra facção.');
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE_APPLICATION_ERROR(-20000, 'Líder indicado já é líder de outra facção.');
            WHEN OTHERS THEN
                IF SQLCODE = -2291 THEN
                    RAISE_APPLICATION_ERROR(-20000, 'Líder não está cadastrado.');
                END IF;
                RAISE_APPLICATION_ERROR(-20000, 'Não foi possível alterar o lider da facção.');
    END indica_lider;
    
END PCT_GERENCIAMENTO_LIDER;
/
