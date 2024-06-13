import cx_Oracle

def get_connection():
    dsn_tns = cx_Oracle.makedsn('orclgrad1.icmc.usp.br', '1521', service_name='pdb_elaine.icmc.usp.br')
    connection = cx_Oracle.connect(user='your_user', password='your_password', dsn=dsn_tns)
    return connection

def execute_query(query, parameters=None):
    connection = get_connection()
    cursor = connection.cursor()
    try:
        if parameters:
            cursor.execute(query, parameters)
        else:
            cursor.execute(query)
        return cursor.fetchall()  # For select queries
    finally:
        cursor.close()
        connection.close()