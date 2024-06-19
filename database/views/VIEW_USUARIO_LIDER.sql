CREATE OR REPLACE VIEW VIEW_USUARIO_LIDER AS
    SELECT
        USERID AS ID,
        PASSWORD AS PASSWORD,
        IDLIDER AS CPI,
        L.NOME,
        L.CARGO,
        L. NACAO,
        L.ESPECIE,
        F.NOME AS NOME_FACCAO
    FROM
        USERS U
    JOIN
        LIDER L ON U.IDLIDER = L.CPI
    LEFT JOIN
        FACCAO F ON F.LIDER = L.CPI;
