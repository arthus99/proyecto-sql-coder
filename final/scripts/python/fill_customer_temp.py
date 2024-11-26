import mysql.connector
from mysql.connector import Error
from dotenv import load_dotenv
import os

# Cargar variables de entorno desde el archivo .env
load_dotenv()

# Obtener las credenciales de las variables de entorno
host = os.getenv('DB_HOST')
user = os.getenv('DB_USER')
password = os.getenv('DB_PASSWORD')
database = os.getenv('DB_DATABASE')

# Ruta al archivo CSV en tu sistema local
csv_file_path = '../../csv/customer_temp.csv'  # Ruta del archivo

try:
    # Establecer la conexión con la base de datos MySQL
    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database,
        allow_local_infile=True  
)

    if connection.is_connected():
        print('Conexión exitosa a la base de datos')

        # Crear un cursor para ejecutar comandos
        cursor = connection.cursor()

        try:
            cursor.execute("SET GLOBAL local_infile = 1;")
            cursor.execute("CALL sp_create_table_customer_temp")
        except Error as e:
            print(f"Error al crear la tabla customer_temp")
            connection.rollback()

        # Cargar los datos desde el archivo CSV en la tabla temporal
        load_data_query = f"""
        LOAD DATA LOCAL INFILE '{csv_file_path}'
        INTO TABLE customer_temp
        FIELDS TERMINATED BY ',' 
        ENCLOSED BY '"'
        LINES TERMINATED BY '\\n'
        IGNORE 1 LINES
        (username,password,name,lastname,email,birth_date,customer_type_id,phone);
        """
        
        try:
            # Ejecutar la carga de datos
            cursor.execute(load_data_query)
            connection.commit()  # Confirmar los cambios en la base de datos
            print('Datos cargados correctamente en la tabla customer_temp')
        except Error as e:
            print(f"Error al cargar los datos: {e}")
            connection.rollback()  # Revertir en caso de error

        # Llamar al procedimiento almacenado para procesar los datos
        call_procedure_query = "CALL sp_reset_customers;"
        try:
            cursor.execute(call_procedure_query)
             # Leer el resultado 
            result = cursor.fetchall()  
            
            # Imprimir los resultados
           # if result:
           #     for row in result:
           #         print(row) 
            print('Procedimiento sp_reset_customers ejecutado correctamente')
        except Error as e:
            print(f"Error al ejecutar el procedimiento: {e}")
            connection.rollback()  # Revertir en caso de error

except Error as e:
    print(f"Error al conectar a la base de datos: {e}")

finally:
    # Cerrar el cursor y la conexión
    if connection.is_connected():
        cursor.close()
        connection.close()
        print('Conexión cerrada')

