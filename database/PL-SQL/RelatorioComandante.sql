SET SERVEROUTPUT ON;

DECLARE
    -- Tipo para registro de nação e datas de início e fim da última dominação
    TYPE RegDatasDominacao IS RECORD (
        id_planeta planeta.id_astro%TYPE,
        nome_nacao_dominante nacao.nome%TYPE,
        data_inicio DATE,
        data_fim DATE
    );

    -- Tipo para registro de quantidade de espécies, comunidades e habitantes
    TYPE RegQuantidadesEspComHab IS RECORD (
        id_planeta planeta.id_astro%TYPE,
        qtd_especies_originarias NUMBER,
        qtd_especies_atuais NUMBER,
        qtd_comunidades_atuais NUMBER,
        qtd_habitantes_atuais NUMBER
    );

    -- Tipo genérico para registros com ID do planeta e quantidade
    TYPE RegIdQuantidade IS RECORD (
        id_planeta planeta.id_astro%TYPE,
        quantidade NUMBER
    );

    -- Tipo para registro da faccao majoritária
    TYPE RegFaccoesMajoritarias IS RECORD (
        id_planeta planeta.id_astro%TYPE,
        nome_faccao_majoritaria faccao.nome%TYPE,
        qtd_faccao_majoritaria NUMBER
    );

    -- Tipos para tabelas associativas dos resultados
    TYPE TabDatasDominacao IS TABLE OF RegDatasDominacao;
    TYPE TabQuantidadesEspComHab IS TABLE OF RegQuantidadesEspComHab;
    TYPE TabIdQuantidade IS TABLE OF RegIdQuantidade;
    TYPE TabFaccoesMajoritarias IS TABLE OF RegFaccoesMajoritarias INDEX BY VARCHAR2(32);

    -- Arrays associativos para armazenar os resultados
    datas_dominacao_atual TabDatasDominacao;
    qtds_esp_com_hab TabQuantidadesEspComHab;
    qtd_faccoes TabIdQuantidade;
    faccoes_majoritarias TabFaccoesMajoritarias := TabFaccoesMajoritarias();
BEGIN
    -- Consulta das datas de início e fim da última dominação
    SELECT
        p.id_astro AS id_planeta,
        ud.nacao AS nome_nacao_dominante,
        ud.data_ini,
        ud.data_fim
    BULK COLLECT INTO datas_dominacao_atual
    FROM
        planeta p
    LEFT JOIN (
        SELECT d.nacao, d.data_ini, d.data_fim, d.planeta
        FROM dominancia d
        JOIN (
            SELECT planeta, MAX(data_ini) AS data_ini
            FROM dominancia
            GROUP BY planeta
        ) d2 ON d2.data_ini = d.data_ini AND d2.planeta = d.planeta
    ) ud ON ud.planeta = p.id_astro
    ORDER BY
        p.id_astro;

    -- Consulta das quantidades de espécies atuais, espécies originárias, comunidades e habitantes presentes
    SELECT
        p.id_astro AS id_planeta,
        COUNT (
            DISTINCT eo.nome
        ) AS qtd_especies_originarias,
        COUNT (
            DISTINCT
            CASE
                WHEN h.planeta IS NOT NULL AND (h.data_fim IS NULL OR h.data_fim > CURRENT_DATE) THEN h.especie
                ELSE NULL
            END
        ) AS qtd_especies_atuais,
        COUNT (
            DISTINCT
            CASE
                WHEN h.planeta IS NOT NULL AND (h.data_fim IS NULL OR h.data_fim > CURRENT_DATE) THEN h.comunidade
                ELSE NULL
            END
        ) AS qtd_comunidades_atuais,
        SUM(
            CASE
                WHEN h.planeta IS NOT NULL AND (h.data_fim IS NULL OR h.data_fim > CURRENT_DATE) THEN c.qtd_habitantes
                ELSE 0
            END
        ) AS qtd_habitantes_atuais
    BULK COLLECT INTO qtds_esp_com_hab
    FROM
        planeta p
    LEFT JOIN
        habitacao h ON h.planeta = p.id_astro
    LEFT JOIN
        comunidade c ON h.especie = c.especie AND h.comunidade = c.nome
    LEFT JOIN
        especie eo ON eo.nome = h.especie
    GROUP BY
        p.id_astro
    ORDER BY
        p.id_astro;

    -- Consulta da quantidade de facções presentes
    SELECT
        p.id_astro,
        COUNT(
            CASE
                WHEN d.planeta IS NOT NULL AND (d.data_fim IS NULL OR d.data_fim > CURRENT_DATE) THEN 1
                ELSE NULL
            END
        ) AS qtd_faccoes
    BULK COLLECT INTO qtd_faccoes
    FROM
        planeta p
    LEFT JOIN
        dominancia d ON d.planeta = p.id_astro
    LEFT JOIN
        nacao_faccao nf ON d.nacao = nf.nacao
    LEFT JOIN
        faccao f ON nf.faccao = f.nome
    GROUP BY 
        p.id_astro
    ORDER BY
        p.id_astro;
    
    FOR r IN (
        SELECT
            h.PLANETA,
            p.FACCAO,
            SUM(c.QTD_HABITANTES) AS TOTAL_HABITANTES
        FROM
            HABITACAO h
        JOIN
            COMUNIDADE c ON h.ESPECIE = c.ESPECIE AND h.COMUNIDADE = c.NOME
        JOIN
            PARTICIPA p ON c.ESPECIE = p.ESPECIE AND c.NOME = p.COMUNIDADE
        WHERE
            h.DATA_FIM IS NULL OR h.DATA_FIM > SYSDATE
        GROUP BY
            h.PLANETA, p.FACCAO
        ORDER BY
            h.PLANETA, p.FACCAO
    ) LOOP
        dbms_output.put_line(r.PLANETA || ' - ' || r.FACCAO || ' - ' || r.TOTAL_HABITANTES);
        IF faccoes_majoritarias.EXISTS(r.PLANETA) THEN
            IF r.TOTAL_HABITANTES > faccoes_majoritarias(r.PLANETA).qtd_faccao_majoritaria THEN
                faccoes_majoritarias(r.PLANETA) := RegFaccoesMajoritarias(r.PLANETA, r.FACCAO, r.TOTAL_HABITANTES);
            END IF;
        ELSE
            faccoes_majoritarias(r.PLANETA) := RegFaccoesMajoritarias(r.PLANETA, r.FACCAO, r.TOTAL_HABITANTES);
        END IF;
    END LOOP;

    -- FOR i IN 1..datas_dominacao_atual.COUNT LOOP
    --     IF faccoes_majoritarias.EXISTS(datas_dominacao_atual(i).id_planeta) THEN
    --         dbms_output.put_line(i || 'Planeta: ' || datas_dominacao_atual(i).id_planeta || ' - ' || faccoes_majoritarias(datas_dominacao_atual(i).id_planeta).nome_faccao_majoritaria || ' - ' || faccoes_majoritarias(datas_dominacao_atual(i).id_planeta).qtd_faccao_majoritaria);
    --     END IF;
    -- END LOOP;
END;
