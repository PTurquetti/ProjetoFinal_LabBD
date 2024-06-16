CREATE OR REPLACE TRIGGER trg_lider_nacao_faccao3 FOR UPDATE OF nacao ON lider COMPOUND TRIGGER
    -- Criação de tipos para armazenamento de coleções de registros
    TYPE t_lideres_faccoes IS TABLE OF faccao.nome%TYPE INDEX BY VARCHAR2(14);
    TYPE t_lideres_nacoes IS TABLE OF nacao.nome%TYPE INDEX BY VARCHAR2(14);
    TYPE t_nacoes_faccoes IS TABLE OF NUMBER(1) INDEX BY VARCHAR2(30);
    TYPE t_cpis_lideres IS VARRAY(1000000) OF lider.cpi%TYPE;

    -- Declaração de variáveis
    v_cpis_lideres_atualizados t_cpis_lideres := t_cpis_lideres();
    v_cpi_lider lider.cpi%TYPE;
    v_nome_faccao faccao.nome%TYPE;
    v_nome_nacao nacao.nome%TYPE;
    v_lideres_faccoes t_lideres_faccoes := t_lideres_faccoes();
    v_lideres_nacoes t_lideres_nacoes := t_lideres_nacoes();
    v_nacoes_faccoes t_nacoes_faccoes := t_nacoes_faccoes();

    -- Declaração de cursor para consulta de facções e líderes
    CURSOR c_lideres_faccoes IS
        SELECT
            l.cpi, l.nacao, f.nome
        FROM
            lider l
        JOIN
            faccao f ON f.lider = l.cpi;
    
    -- Declaração de cursor para consulta das relações entre nações e facções
    CURSOR c_nacoes_faccoes IS
        SELECT
            nf.nacao, nf.faccao
        FROM
            nacao_faccao nf;

AFTER EACH ROW IS BEGIN
    -- Adição do cpi do líder atualizado à coleção
    v_cpis_lideres_atualizados.EXTEND();
    v_cpis_lideres_atualizados(v_cpis_lideres_atualizados.COUNT) := :new.cpi;
END AFTER EACH ROW;

AFTER STATEMENT IS BEGIN
    -- Atribuição dos líderes e facções
    OPEN c_lideres_faccoes;
    LOOP FETCH c_lideres_faccoes INTO v_cpi_lider, v_nome_nacao, v_nome_faccao;
        EXIT WHEN c_lideres_faccoes%NOTFOUND;
        v_lideres_faccoes(v_cpi_lider) := v_nome_faccao;
        v_lideres_nacoes(v_cpi_lider) := v_nome_nacao;
    END LOOP;

    -- Atribuição das relações entre nações e facções
    OPEN c_nacoes_faccoes;
    LOOP FETCH c_nacoes_faccoes INTO v_nome_nacao, v_nome_faccao;
        EXIT WHEN c_nacoes_faccoes%NOTFOUND;
        v_nacoes_faccoes(v_nome_nacao || v_nome_faccao) := 1;
    END LOOP;
    
    -- Verificação se os líderes de facção atualizados estão associados a uma nação em que a facção está presente
    FOR i IN 1..v_cpis_lideres_atualizados.COUNT LOOP
        IF v_lideres_faccoes.EXISTS(v_cpis_lideres_atualizados(i)) THEN  -- se é um líder de facção
            IF NOT v_nacoes_faccoes.EXISTS(v_lideres_nacoes(v_cpis_lideres_atualizados(i)) || v_lideres_faccoes(v_cpis_lideres_atualizados(i))) THEN  -- se a facção não está associada à nação
                raise_application_error(-20000, 'O líder da facção deve estar associado a uma nação em que a facção está presente.');
            END IF;
        END IF;
    END LOOP;
END AFTER STATEMENT;

END trg_lider_nacao_faccao3;
/
