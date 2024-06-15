arquivo_pacotes = open('pacotes.txt')

prefixo_sql = '''
DECLARE
    TYPE user_name_table IS TABLE OF VARCHAR2(10) INDEX BY PLS_INTEGER;
    user_names user_name_table;
    i PLS_INTEGER;
BEGIN
    user_names(1) := 'a12547382';
    user_names(2) := 'a4818232';
    user_names(3) := 'a13750791';

    i := user_names.FIRST;
    WHILE i IS NOT NULL LOOP
        FOR r IN (SELECT table_name FROM user_tables) LOOP
            dbms_output.put_line('GRANT ALL ON ' || r.table_name || ' TO ' || user_names(i) || ';');
            EXECUTE IMMEDIATE 'GRANT ALL ON ' || r.table_name || ' TO ' || user_names(i);
        END LOOP;
'''

infixo_sql = ''
for linha in arquivo_pacotes:
    nome_pacote = linha.strip()
    infixo_sql += f'''
        dbms_output.put_line('GRANT EXECUTE ON {nome_pacote} TO ' || user_names(i) || ';');
        EXECUTE IMMEDIATE 'GRANT EXECUTE ON {nome_pacote} TO ' || user_names(i);
    ''' 
    
sufixo_sql = '''
        i := user_names.NEXT(i);
    END LOOP;
END;
'''

script_sql = prefixo_sql + infixo_sql + sufixo_sql
open('gera_privilegios.sql', 'w').write(script_sql.strip())
