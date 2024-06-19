-- Declaração de pacote de relatório para cientistas
CREATE OR REPLACE PACKAGE PCT_RELATORIO_CIENTISTA AS
    -- Tipos de coleções que serão guardados os resultados
    TYPE t_tab_estrelas IS TABLE OF estrela%ROWTYPE;
    TYPE t_tab_planetas IS TABLE OF planeta%ROWTYPE;
    TYPE t_sistemas IS RECORD (nome sistema.nome%TYPE);
    TYPE t_tab_sistemas IS TABLE OF t_sistemas;
 
    -- Encontra todas as estrelas e adiciona em uma coleção
    PROCEDURE search_estrela(
        t_tab_estrelas_out OUT t_tab_estrelas
    );

    -- Encontra todos os planetas e adiciona em uma coleção
    PROCEDURE search_planeta(
        t_tab_planetas_out OUT t_tab_planetas
    );

    -- Encontra o nome do sistema, as estrelas e os planetas que orbitam uma estrela especificada
    PROCEDURE search_sistema_por_estrela_orbitada(
        p_estrela estrela.id_estrela%TYPE,
        p_nome_sistema OUT sistema.nome%TYPE,
        t_tab_estrelas_out OUT t_tab_estrelas,
        t_tab_planetas_out OUT t_tab_planetas
    );

    -- Encontra o nome de todos os sistemas que essa estrela faz parte (ver se ela orbita alguma outra estrela e ver se essa outra estrela tem um sistema)
    PROCEDURE search_sistema_por_orbitante(
        p_estrela estrela.id_estrela%TYPE,
        t_tab_sistemas_out OUT t_tab_sistemas
    );
END PCT_RELATORIO_CIENTISTA;
/

-- Corpo do pacote de relatório para cientistas
CREATE OR REPLACE PACKAGE BODY PCT_RELATORIO_CIENTISTA AS
    -- Busca de todas as estrelas
    PROCEDURE search_estrela(
        t_tab_estrelas_out OUT t_tab_estrelas
    ) AS
    CURSOR c_estrela IS
        SELECT * FROM ESTRELA;
    BEGIN
        t_tab_estrelas_out := t_tab_estrelas();
        -- Adição de todas as estrelas na coleção
        FOR v_linha IN c_estrela LOOP
            t_tab_estrelas_out.extend();  -- aumenta um espaço no vetor
            t_tab_estrelas_out(t_tab_estrelas_out.COUNT) := v_linha;  -- adiciona a linha na nova posição (última)
        END LOOP;
    END search_estrela;

    -- Busca de todos os planetas
    PROCEDURE search_planeta(
        t_tab_planetas_out OUT t_tab_planetas
    ) AS
    CURSOR c_planeta IS
        SELECT * FROM PLANETA;
    BEGIN
        t_tab_planetas_out := t_tab_planetas();
        -- Adição de todos os planetas na coleção
        FOR v_linha IN c_planeta LOOP
            t_tab_planetas_out.extend();
            t_tab_planetas_out (t_tab_planetas_out.COUNT) := v_linha;
        END LOOP;
    END search_planeta;

    -- Busca do sistema, planetas e estrelas que orbitam uma estrela
    PROCEDURE search_sistema_por_estrela_orbitada(
        p_estrela estrela.id_estrela%TYPE,
        p_nome_sistema OUT sistema.nome%TYPE,
        t_tab_estrelas_out OUT t_tab_estrelas,
        t_tab_planetas_out OUT t_tab_planetas
    ) AS
        CURSOR c_estrela IS
            SELECT e.id_estrela, e.nome, e.classificacao, e.massa, e.x, e.y, e.z
            FROM orbita_estrela o JOIN estrela e ON o.orbitante = e.id_estrela
            WHERE o.orbitada = p_estrela;
        CURSOR c_planeta IS
            SELECT p.id_astro, p.massa, p.raio, p.classificacao
            FROM orbita_planeta o JOIN planeta p ON o.planeta = p.id_astro
            WHERE o.estrela = p_estrela;
    BEGIN
        -- Inicialização das coleções
        t_tab_estrelas_out := t_tab_estrelas();
        t_tab_planetas_out := t_tab_planetas();

        -- Busca do sistema que a estrela faz parte
        SELECT s.nome INTO p_nome_sistema FROM sistema s WHERE s.estrela = p_estrela;

        -- Adição das estrelas que orbitam a estrela
        FOR v_linha IN c_estrela LOOP
            t_tab_estrelas_out.extend();
            t_tab_estrelas_out (t_tab_estrelas_out.COUNT) := v_linha;
        END LOOP;

        -- Adição dos planetas que orbitam a estrela
        FOR v_linha IN c_planeta LOOP
            t_tab_planetas_out.extend();
            t_tab_planetas_out(t_tab_planetas_out.COUNT) := v_linha;
        END LOOP;
    END search_sistema_por_estrela_orbitada;

    -- Busca dos sistemas que uma estrela orbitante faz parte
    PROCEDURE search_sistema_por_orbitante(
        p_estrela estrela.id_estrela%TYPE,
        t_tab_sistemas_out OUT t_tab_sistemas
    ) IS
        CURSOR c_sistema IS
            SELECT s.nome AS nome
            FROM orbita_estrela o JOIN sistema s ON s.estrela = o.orbitada
            WHERE o.orbitante = p_estrela;
    BEGIN
        t_tab_sistemas_out := t_tab_sistemas();

        -- Adição dos sistemas que a estrela faz parte
        FOR v_sis IN c_sistema LOOP
            t_tab_sistemas_out.EXTEND();
            t_tab_sistemas_out(t_tab_sistemas_out.COUNT) := t_sistemas(v_sis.nome);
        END LOOP;
    END search_sistema_por_orbitante;
END PCT_RELATORIO_CIENTISTA;
/
