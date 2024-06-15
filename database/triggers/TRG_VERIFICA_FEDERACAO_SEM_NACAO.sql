-- Criação de trigger para restrição de existência de federações sem nações
CREATE OR REPLACE TRIGGER trg_verifica_federacao_sem_nacao FOR UPDATE OF federacao OR DELETE on nacao COMPOUND TRIGGER
    -- Declaração de tipo para armazenamento de coleção
    TYPE t_federacoes IS TABLE OF nacao.federacao%TYPE;

    -- Declaração de variável
    federacoes_excluidas t_federacoes := t_federacoes();

AFTER EACH ROW IS BEGIN
    -- Adição de federação excluída da nação
    federacoes_excluidas.EXTEND();
    federacoes_excluidas(federacoes_excluidas.COUNT) := :old.federacao;
END AFTER EACH ROW;

AFTER STATEMENT IS BEGIN
    -- Deleção das federações excluídas que não possuem nenhuma nação
    FOR i IN 1..federacoes_excluidas.COUNT LOOP
        DELETE FROM federacao WHERE nome = federacoes_excluidas(i) AND NOT EXISTS (
            SELECT 1 FROM nacao WHERE federacao = federacoes_excluidas(i)
        );
    END LOOP;
END AFTER STATEMENT;

END trg_verifica_federacao_sem_nacao; 
/
