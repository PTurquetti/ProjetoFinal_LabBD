from db_controller import DBController

db_controller = DBController()

# result = db_controller.call_function('PCT_UTILITARIO.CALCULAR_DISTANCIA_ESTRELAS', ['GJ 9798', 'GJ 4301'], int)

result = db_controller.call_function('PCT_TESTE.GERAR_RELATORIO', [1], str)
print('100 primeiras linhas:')
print(result)
print(type(result))

result = db_controller.call_function('PCT_TESTE.GERAR_RELATORIO', [101], str)
print('100 próximas linhas:')
print(result)
print(type(result))
