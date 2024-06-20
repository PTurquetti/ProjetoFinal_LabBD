CREATE OR REPLACE TRIGGER TRG_ATUALIZA_QTD_NACOES FOR INSERT OR DELETE ON NACAO_FACCAO COMPOUND TRIGGER
    -- Criação de tipos para armazenamento de coleções
    TYPE T_NOMES_FACCOES IS VARRAY(1000000) OF FACCAO.NOME%TYPE;

    -- Declaração de variáveis
    V_NOMES_FACCOES_INCREMENTO T_NOMES_FACCOES := T_NOMES_FACCOES();
    V_NOMES_FACCOES_DECREMENTO T_NOMES_FACCOES := T_NOMES_FACCOES();

AFTER EACH ROW IS BEGIN
    -- Adição do nome da facção para incremento ou decremento da quantidade de nações
    IF INSERTING THEN 
        V_NOMES_FACCOES_INCREMENTO.EXTEND();
        V_NOMES_FACCOES_INCREMENTO(V_NOMES_FACCOES_INCREMENTO.COUNT) := :NEW.FACCAO;
    ELSIF DELETING THEN
        V_NOMES_FACCOES_DECREMENTO.EXTEND();
        V_NOMES_FACCOES_DECREMENTO(V_NOMES_FACCOES_DECREMENTO.COUNT) := :OLD.FACCAO;
    END IF;
END AFTER EACH ROW;

AFTER STATEMENT IS BEGIN
    -- Incremento da quantidade de nações (caso necessário)
    FOR I IN 1..V_NOMES_FACCOES_INCREMENTO.COUNT LOOP
        UPDATE FACCAO SET QTD_NACOES = QTD_NACOES + 1 WHERE NOME = V_NOMES_FACCOES_INCREMENTO(I);
    END LOOP;

    -- Decremento da quantidade de nações (caso necessário)
    FOR I IN 1..V_NOMES_FACCOES_DECREMENTO.COUNT LOOP
        UPDATE FACCAO SET QTD_NACOES = QTD_NACOES - 1 WHERE NOME = V_NOMES_FACCOES_DECREMENTO(I);
    END LOOP;
END AFTER STATEMENT;

END TRG_ATUALIZA_QTD_NACOES; 
/
