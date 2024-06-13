import os
import oracledb
from dotenv import load_dotenv

class OracleDBController:
    def __init__(self):
        load_dotenv()
        self.user = os.getenv('user')
        self.host = os.getenv('host')
        self.port = os.getenv('port')
        self.service_name = os.getenv('service_name')
        self.password = os.getenv('password')
    
    def __map_function_return_type(self, return_type):
        if return_type in [int, float]:
            return oracledb.NUMBER
        return oracledb.STRING
        
    def call_function(self, function_name, function_parameters, return_type):
        mapped_return_type = self.__map_function_return_type(return_type)
        with oracledb.connect(user=self.user, password=self.password, host=self.host, port=self.port, service_name=self.service_name) as connection:
            cursor = connection.cursor()
            try:
                output = cursor.callfunc(function_name, mapped_return_type, function_parameters)
                connection.commit()
                cursor.close()
                return output
            except Exception as e:
                connection.rollback()
                cursor.close()
                raise e
