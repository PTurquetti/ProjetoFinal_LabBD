import os
import oracledb
from dotenv import load_dotenv

class DBController:
    def __init__(self):
        load_dotenv()
        self.user = os.getenv('user')
        self.host = os.getenv('host')
        self.port = os.getenv('port')
        self.service_name = os.getenv('service_name')
        self.password = os.getenv('password')
        self.connection = oracledb.connect(user=self.user, password=self.password, host=self.host, port=self.port, service_name=self.service_name)
    
    def __del__(self):
        self.connection.commit()
        self.connection.close()

    def __map_function_return_type(self, return_type):
        if return_type in [int, float]:
            return oracledb.NUMBER
        if return_type == str:
            return oracledb.STRING
    
    def commit(self):
        self.connection.commit()
    
    def rollback(self):
        self.connection.rollback()
        
    def call_function(self, function_name, function_parameters, return_type):
        mapped_return_type = self.__map_function_return_type(return_type)
        converted_function_name = f'a11796893.{function_name}'
        # with oracledb.connect(user=self.user, password=self.password, host=self.host, port=self.port, service_name=self.service_name) as connection:
        cursor = self.connection.cursor()
        try:
            output = cursor.callfunc(converted_function_name, mapped_return_type, function_parameters)
            cursor.close()
            return output
        except Exception as e:
            cursor.close()
            raise e
