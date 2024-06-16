-- Declaração de pacote para manipulações de usuário
CREATE OR REPLACE PACKAGE PCT_GERENCIAMENTO_LIDER AS
    E_USER_NAO_EH_LIDER EXCEPTION;
    /*E_LIDER_JA_EH_LIDER_DE_OUTRA_FACCAO EXCEPTION;
    E_COMUNIDADE_JA_PARTICIPA EXCEPTION;
    E_COMUNIDADE_INVALIDA EXCEPTION;
    E_FACCAO_NAO_PERTENCE_A_NACAO EXCEPTION;*/
    PROCEDURE alterar_nome_faccao (
        p_cpilider LIDER.CPI%TYPE,
        p_novo_nome FACCAO.NOME%TYPE
    );
    /*PROCEDURE indica_lider (
        p_cpilider LIDER.CPI%TYPE,
        p_cpi_novo_lider LIDER.CPI%TYPE
    );
    PROCEDURE credenciar_comunidade (
        p_cpilider LIDER.CPI%TYPE,
        p_especie_comunidade COMUNIDADE.NOME%TYPE, 
        p_nome_comunidade COMUNIDADE.NOME%TYPE
    );
    PROCEDURE remove_faccao_de_nacao (
        p_cpilider LIDER.CPI%TYPE,
        p_nacao NACAO.NOME%TYPE
    );*/
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

    PROCEDURE alterar_nome_faccao (
        p_cpilider LIDER.CPI%TYPE,
        p_novo_nome FACCAO.NOME%TYPE
    ) IS
        v_faccao FACCAO.NOME%TYPE; -- Facção do líder
    BEGIN
        v_faccao := retorna_faccao(p_cpilider); -- Retorna a facção do líder
        IF v_faccao is null THEN
            RAISE E_USER_NAO_EH_LIDER; -- Usuário não é líder de nenhuma facção
        END IF;
        UPDATE FACCAO SET NOME = p_novo_nome WHERE NOME = v_faccao; -- Update no nome
        -- Esse update aciona o trigger de update de nome de facção, pois existem tabelas que precisam ser alteradas também.
        DBMS_OUTPUT.PUT_LINE('Nome alterado com sucesso!');
    EXCEPTION
        WHEN E_USER_NAO_EH_LIDER THEN
            DBMS_OUTPUT.PUT_LINE('Usuário não é líder de nenhuma facção.');
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Já existe uma facção com esse nome.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Não foi possível mudar o nome da facção. ERRO: ' || SQLCODE);
    END alterar_nome_faccao;

    
END PCT_GERENCIAMENTO_LIDER;
/
