
# CREACION DE BASE DE DATOS

## "miChangarro" TIENDA DEPARTAMENTAL.
<br>	

# Resumen de Objetos

Regresar a [readme.](../readme.md)


## Funciones

| **#** | **Nombre**                        | **Descripción**                                                                                                                                                                                                                           |
|-------|-----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1     | `fn_authentication`               | **Descripción**: Autentica al usuario verificando el nombre de usuario y la contraseña. <br> **Entrada**: `p_username VARCHAR(150)`, `p_password VARCHAR(150)` <br> **Salida**: `BOOLEAN`, indicando si la autenticación fue exitosa.   |
| 2     | `fn_check_interest_cycle`         | **Descripción**: Verifica si existe un ciclo en los intereses de un usuario. <br> **Entrada**: `parent_id SMALLINT UNSIGNED`, `current_id SMALLINT UNSIGNED` <br> **Salida**: `BOOLEAN`, indicando si el ciclo existe.               |
| 3     | `fn_is_birthday_valid`            | **Descripción**: Valida si la fecha de nacimiento está en un rango válido. <br> **Entrada**: `p_birthday DATE` <br> **Salida**: `VARCHAR(255)`, que indica si la fecha es válida o no.                                             |
| 4     | `fn_validate_phone_number`        | **Descripción**: Valida y limpia el número de teléfono, devolviendo el formato limpio o NULL si no es válido. <br> **Entrada**: `phone VARCHAR(30)` <br> **Salida**: `VARCHAR(15)` con el número limpio o NULL.                         |

## Procedimientos

| #  | Nombre                         | Descripción                                                                                                                   |
|----|---------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| 1  | sp_add_customer                 | **Descripción**: Agrega un nuevo cliente a la base de datos con validaciones de los parámetros de entrada. <br> **Entrada**: `p_username`, `p_password`, `p_name`, `p_lastname`, `p_email`, `p_birthday`, `p_customer_type_id`, `p_phone`. <br> **Salida**: No devuelve nada, maneja errores internos. |
| 2  | sp_create_table_customer_temp   | **Descripción**: Crea una tabla temporal para la carga de datos de clientes. <br> **Entrada**: Ninguna. <br> **Salida**: Crea una tabla temporal `customer_temp`. |
| 3  | sp_del_customer                 | **Descripción**: Elimina un cliente según su nombre de usuario. <br> **Entrada**: `p_username`. <br> **Salida**: No devuelve nada, maneja errores internos. |
| 4  | sp_delete_department            | **Descripción**: Elimina un departamento y reasigna los items del departamento eliminado al departamento "Departamento sin Asignar". <br> **Entrada**: `depa_id`. <br> **Salida**: No tiene, pero realiza eliminaciones y actualizaciones en diversas tablas. |
| 5  | sp_GetDepartmentBranchById      | **Descripción**: Recupera la jerarquía de un departamento o todos los departamentos si el `departmentId` es nulo. <br> **Entrada**: `departmentId`. <br> **Salida**: Información de los departamentos con su jerarquía. |
| 6  | sp_GetDepartmentById            | **Descripción**: Devuelve información sobre un departamento específico basado en su ID. <br> **Entrada**: `departmentId`. <br> **Salida**: Información del departamento. |
| 7  | sp_GetDepartmentByName          | **Descripción**: Devuelve información sobre departamentos cuyo nombre coincide con el valor dado. <br> **Entrada**: `departmentName`. <br> **Salida**: Información de departamentos que coinciden con el nombre dado. |
| 8  | sp_GetInterestByDepId           | **Descripción**: Devuelve los intereses asociados a un departamento dado. <br> **Entrada**: `depID`. <br> **Salida**: Información sobre los intereses asociados. |
| 9  | sp_get_sale_details             | **Descripción**: Recupera los detalles de una venta específica, calculando los totales con descuentos. <br> **Entrada**: `p_sales_id`. <br> **Salida**: Detalles de la venta, incluyendo los cálculos de precio total con descuento. |
| 10 | sp_hash_pwd                     | **Descripción**: Genera un hash y un salt para una contraseña. <br> **Entrada**: `pwd`. <br> **Salida**: `hashed_password`, `salt`, `pwd_message`, `is_pwd_valid`. |
| 11 | sp_insert_department            | **Descripción**: Inserta un nuevo departamento en la base de datos. <br> **Entrada**: `dept_name`, `dept_description`, `parent_id`. <br> **Salida**: No devuelve nada, maneja errores internos. |
| 12 | sp_insert_sales_from_json       | **Descripción**: Inserta ventas y artículos vendidos a partir de un JSON. <br> **Entrada**: `sales_json`. <br> **Salida**: No devuelve nada, pero realiza inserciones en la base de datos. |
| 13 | sp_is_email_valid               | **Descripción**: Valida si un correo electrónico es válido. <br> **Entrada**: `p_email`. <br> **Salida**: `email_message`, `is_email_valid`. |
| 14 | sp_is_phone_number_valid        | **Descripción**: Valida un número de teléfono. <br> **Entrada**: `p_phone`. <br> **Salida**: `phone_number_message`, `cleaned_phone`, `is_phone_number_valid`. |
| 15 | sp_is_username_valid            | **Descripción**: Valida si un nombre de usuario es válido. <br> **Entrada**: `p_username`. <br> **Salida**: `username_message`, `is_username_valid`. |
| 16 | sp_reset_customers              | **Descripción**: Restablece la tabla `customer` eliminando todos los registros e insertando desde la tabla temporal `customer_temp`. <br> **Entrada**: Ninguno. <br> **Salida**: Inserta registros en la tabla `customer`. |
| 17 | sp_sel_customer                 | **Descripción**: Selecciona información de un cliente en la tabla `customer`. <br> **Entrada**: `p_username`. <br> **Salida**: Información del cliente o todos los clientes si `p_username` es `NULL`. |
| 18 | sp_test_cycle_simulation        | **Descripción**: Simula la detección de ciclos en los intereses. <br> **Entrada**: `current_id`. <br> **Salida**: Lista de intereses con ciclos detectados. |
| 19 | sp_update_customer              | **Descripción**: Actualiza la información de un cliente en la tabla `customer`. <br> **Entrada**: `p_username`, `p_password`, `p_name`, `p_lastname`, `p_email`, `p_birthday`, `p_customer_type_id`, `p_phone`, `p_new_username`. <br> **Salida**: Actualización de registros de cliente. |
| 20 | sp_update_department            | **Descripción**: Actualiza los detalles de un departamento y su relación jerárquica en la tabla `department_closure`. <br> **Entrada**: `p_dept_id`, `new_dept_name`, `new_dept_description`, `new_ancestor_id`. <br> **Salida**: Actualización de un departamento y su jerarquía. |

## Triggers

| **#** | **Nombre**                          | **Descripción**                                                                                                                                                                                                                           |
|-------|-------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1     | `tr_check_interest_before_insert`  | **Descripción**: Verifica si un interés a insertar crea un ciclo en la jerarquía de intereses. <br> **Entrada**: `NEW.parent_interest_id`, `NEW.interest_id` <br> **Salida**: Error si se detecta un ciclo en la jerarquía de intereses. |
| 2     | `tr_check_interest_before_update`  | **Descripción**: Verifica si la actualización de un interés crea un ciclo en la jerarquía de intereses. <br> **Entrada**: `NEW.parent_interest_id`, `NEW.interest_id` <br> **Salida**: Error si se detecta un ciclo en la jerarquía de intereses. |
| 3     | `tr_check_username_before_insert`  | **Descripción**: Verifica si el nombre de usuario ya existe antes de insertar un nuevo cliente. <br> **Entrada**: `NEW.username` <br> **Salida**: Error si el nombre de usuario ya existe.                |

## Vistas

| **#** | **Nombre**                        | **Descripción**                                                                                                                                                                                                                           |
|-------|-----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1     | `v_departments`               | **Descripción**: Muestra todos los departamentos y su jerarquía. <br> **Entrada**: Ninguno <br> **Salida**: Información jerárquica de todos los departamentos.                                      |
| 2     | `v_interest`                      | **Descripción**: Muestra los intereses de los clientes y su relación con los departamentos. <br> **Entrada**: Ninguno <br> **Salida**: Información de intereses y relaciones con departamentos.                                         |

## Tablas

### 1. **customer**
- **Descripción**: Almacena la información de los clientes; debe existir la cuenta Anónima para cumplir con los pagos sin registro.

- **Relaciones**:
  - `customer_type_id` → `customer_type(customer_type_id)`

- **Notas**:
  - `password` (VARBINARY) manejar el password con hash.
  
| Column             | Type              | Constraints                                      |
|--------------------|-------------------|--------------------------------------------------|
| customer_id        | INT UNSIGNED      | NOT NULL AUTO_INCREMENT PRIMARY KEY              |
| username           | VARCHAR(150)      | NOT NULL UNIQUE                                  |
| password           | VARBINARY(64)     | NOT NULL                                         |
| name               | VARCHAR(100)      | NOT NULL                                         |
| lastname           | VARCHAR(100)      | NOT NULL                                         |
| email              | VARCHAR(150)      | NOT NULL UNIQUE                                  |
| birth_date         | DATE              | NOT NULL                                         |
| customer_type_id   | SMALLINT UNSIGNED | NOT NULL, FK a `customer_type(customer_type_id)` |
| phone              | VARCHAR(15)       | NOT NULL UNIQUE                                  |

---

### 2. **customer_interests**
- **Descripción**: Relaciona a los clientes con sus intereses específicos.

- **Relaciones**:
  - `customer_id` → `customer(customer_id)`
  - `interest_id` → `interests(interest_id)`

| Column             | Type              | Constraints                                      |
|--------------------|-------------------|--------------------------------------------------|
| customer_id        | INT UNSIGNED      | NOT NULL, FK a `customer(customer_id)`           |
| interest_id        | SMALLINT UNSIGNED | NOT NULL, FK a `interests(interest_id)`          |

---

### 3. **customer_payment_method**
- **Descripción**: Almacena los métodos de pago de los clientes, incluyendo detalles como tarjetas de crédito.

- **Relaciones**:
  - `customer_id` → `customer(customer_id)`
  - `payment_method_id` → `payment_method(payment_method_id)`

- **Notas**:
  - El campo `creditcard` almacena información sensible y debe ser manejado de acuerdo con las políticas de seguridad. Por ahora sólo esta en binario con números de ejemplo.

| Column                    | Type              | Constraints                                          |
|---------------------------|-------------------|------------------------------------------------------|
| customer_payment_method_id | BINARY(16)        | NOT NULL PRIMARY KEY                                  |
| customer_id               | INT UNSIGNED      | NOT NULL, FK a `customer(customer_id)`               |
| payment_method_id         | SMALLINT UNSIGNED | NOT NULL, FK a `payment_method(payment_method_id)`   |
| creditcard                | VARBINARY(255)    | NULL                                                 |

---

### 4. **customer_type**
- **Descripción**: Define los tipos de clientes, como cliente regular o VIP, y su descuento asociado.

- **Relaciones**:
  - Ninguna.

| Column                 | Type              | Constraints                                      |
|------------------------|-------------------|--------------------------------------------------|
| customer_type_id       | SMALLINT UNSIGNED | NOT NULL AUTO_INCREMENT PRIMARY KEY              |
| name                   | VARCHAR(100)      | NOT NULL                                         |
| description            | VARCHAR(255)      | NULL                                             |
| customer_type_discount | DECIMAL(5,2)      | CHECK (customer_type_discount >= 0 AND customer_type_discount <= 100) |

---

### 5. **department_closure**
- **Descripción**: Mapea la jerarquía de departamentos, mostrando las relaciones de ancestro y descendiente entre ellos.

- **Relaciones**:
  - `ancestor` → `departments(department_id)`
  - `descendant` → `departments(department_id)`

| Column     | Type              | Constraints                                      |
|------------|-------------------|--------------------------------------------------|
| ancestor   | SMALLINT UNSIGNED | NOT NULL, FK a `departments(department_id)`      |
| descendant | SMALLINT UNSIGNED | NOT NULL, FK a `departments(department_id)`      |
| depth      | INT               | NOT NULL                                         |

---

### 6. **department_interests**
- **Descripción**: Relaciona departamentos con intereses específicos que les corresponden.

- **Relaciones**:
  - `department_id` → `departments(department_id)`
  - `interest_id` → `interests(interest_id)`

| Column        | Type              | Constraints                                      |
|---------------|-------------------|--------------------------------------------------|
| department_id | SMALLINT UNSIGNED | NOT NULL, FK a `departments(department_id)`      |
| interest_id   | SMALLINT UNSIGNED | NOT NULL, FK a `interests(interest_id)`          |

---

### 7. **departments**
- **Descripción**: Almacena los departamentos dentro de la organización, como "Electrónica", "Ropa", etc.

- **Relaciones**:
  - Ninguna.

| Column         | Type              | Constraints                                      |
|----------------|-------------------|--------------------------------------------------|
| department_id  | SMALLINT UNSIGNED | NOT NULL AUTO_INCREMENT PRIMARY KEY              |
| name           | VARCHAR(100)      | NOT NULL                                         |
| description    | VARCHAR(255)      | NULL                                             |

---

### 8. **interests**
- **Descripción**: Almacena los diferentes intereses o categorías que los clientes pueden seguir.

- **Relaciones**:
  - `parent_interest_id` → `interests(interest_id)` (relación recursiva para subcategorías)

| Column              | Type              | Constraints                                      |
|---------------------|-------------------|--------------------------------------------------|
| interest_id         | SMALLINT UNSIGNED | NOT NULL AUTO_INCREMENT PRIMARY KEY              |
| name                | VARCHAR(100)      | NOT NULL                                         |
| description         | VARCHAR(255)      | NULL                                             |
| parent_interest_id  | SMALLINT UNSIGNED | NULL, FK a `interests(interest_id)`              |

---

### 9. **items**
- **Descripción**: Almacena los productos disponibles en los departamentos.

- **Relaciones**:
  - `department_id` → `departments(department_id)`

| Column         | Type              | Constraints                                      |
|----------------|-------------------|--------------------------------------------------|
| item_id        | BINARY(16)        | NOT NULL AUTO_INCREMENT PRIMARY KEY              |
| item_name      | VARCHAR(100)      | NOT NULL                                         |
| item_description | VARCHAR(255)     | NULL                                             |
| item_stock     | INT               | NOT NULL, CHECK (item_stock >= 0)                |
| item_price     | DECIMAL(10,2)     | NOT NULL, CHECK (item_price >= 0)                |
| item_discount  | DECIMAL(5,2)      | NOT NULL, CHECK (item_discount >= 0 AND item_discount <= 100) |
| department_id  | SMALLINT UNSIGNED | NOT NULL, FK a `departments(department_id)`      |

---

### 10. **payment_method**
- **Descripción**: Almacena los métodos de pago disponibles, como tarjetas de crédito o débito.

- **Relaciones**:
  - Ninguna.

| Column               | Type              | Constraints                                      |
|----------------------|-------------------|--------------------------------------------------|
| payment_method_id    | SMALLINT UNSIGNED | NOT NULL AUTO_INCREMENT PRIMARY KEY              |
| name                 | VARCHAR(100)      | NOT NULL                                         |
| description          | VARCHAR(255)      | NULL                                             |

---

### 11. **sales**
- **Descripción**: Almacena las ventas realizadas, incluyendo información sobre el cliente, el método de pago y el descuento aplicado.

- **Relaciones**:
  - `customer_id` → `customer(customer_id)`
  - `payment_method_id` → `payment_method(payment_method_id)`

| Column              | Type              | Constraints                                      |
|---------------------|-------------------|--------------------------------------------------|
| sales_id            | BIGINT UNSIGNED   | NOT NULL AUTO_INCREMENT PRIMARY KEY              |
| customer_id         | INT UNSIGNED      | NOT NULL, FK a `customer(customer_id)`           |
| payment_method_id   | SMALLINT UNSIGNED | NOT NULL, FK a `payment_method(payment_method_id)`|
| sale_date           | DATETIME          | NOT NULL                                         |
| total_amount        | DECIMAL(10,2)     | NOT NULL                                         |
| discount            | DECIMAL(5,2)      | NULL                                             |

---

### 12. **sold_items**
- **Descripción**: Almacena los artículos vendidos en una transacción de venta. Cada registro representa un artículo específico que se ha vendido dentro de una venta.

- **Notas:**
  - `quantity` (INT) debe ser mayor a 0.
  - `price` (DECIMAL) y `discount` (DECIMAL) representan el precio y descuento del artículo al momento de la venta.
  - Las relaciones entre las tablas aseguran la integridad de la venta y los artículos vendidos.

- **Relaciones**:
  - `sales_id` → `sales(sales_id)`
  - `item_id` → `items(item_id)`

| Column         | Type              | Constraints                                      |
|----------------|-------------------|--------------------------------------------------|
| sales_id       | BIGINT UNSIGNED   | NOT NULL, FK a `sales(sales_id)`                 |
| item_id        | BINARY(16)        | NOT NULL, FK a `items(item_id)`                  |
| quantity       | INT               | NOT NULL, CHECK (quantity > 0)                   |
| item_price     | DECIMAL(10,2)     | NOT NULL                                         |
| item_discount  | DECIMAL(5,2)      | NOT NULL                                         |

---

## Python

Se ha creado el script [fill_customer.py](../scripts/python/fill_customer.py). Considere instalar el ambiente adecuado para ejecutarlo. Consulte [requerimientos](../scripts/python/requirements.txt)

### **Script de Carga de Datos a la Base de Datos MySQL**

- **Descripción**: Este script se conecta a una base de datos MySQL y carga datos desde un archivo CSV en una tabla (`customer_temp`). Posteriormente, ejecuta un procedimiento almacenado (`sp_reset_customers`) para procesar los datos. El script usa el módulo `mysql.connector` para interactuar con la base de datos y `dotenv` para cargar las credenciales de la base de datos desde un archivo `.env` (no incluido por motivos de seguridad).

- **Notas:**
  

- **Queries Ejecutados**:
    1. **`SET GLOBAL local_infile = 1;`**: Este comando habilita la carga de archivos locales en el servidor MySQL.
    2. **`CALL sp_create_table_customer_temp;`**: Llama al procedimiento almacenado `sp_create_table_customer_temp` para crear la tabla temporal `customer_temp`.
    3. **`LOAD DATA LOCAL INFILE 'path/to/csv' INTO TABLE customer_temp ...`**: Carga los datos desde un archivo CSV en la tabla temporal `customer_temp`. Los datos son delimitados por comas, encerrados entre comillas dobles, y con líneas terminadas por salto de línea.
    4. **`CALL sp_reset_customers;`**: Llama al procedimiento almacenado `sp_reset_customers` para procesar los datos que se han cargado en la tabla temporal.


### **Funcionamiento del Script**

1. **Cargar Variables de Entorno:**
   - Se cargan las credenciales de la base de datos (host, usuario, contraseña, base de datos) desde un archivo `.env` utilizando la librería `dotenv`.

2. **Conexión a la Base de Datos MySQL:**
   - Se establece una conexión con la base de datos MySQL usando las credenciales cargadas previamente.
   - La opción `allow_local_infile=True` está habilitada para permitir la carga de archivos locales.

3. **Ejecución de Comandos Preparatorios:**
   - Se ejecutan dos comandos SQL:
     1. **`SET GLOBAL local_infile = 1;`**: Habilita la carga de archivos locales en el servidor MySQL.
     2. **`CALL sp_create_table_customer_temp;`**: Llama a un procedimiento almacenado para crear la tabla temporal `customer_temp`.

4. **Carga de Datos desde CSV:**
   - Se define una consulta SQL `LOAD DATA LOCAL INFILE` que carga los datos del archivo CSV en la tabla `customer_temp`.
     - El archivo debe estar delimitado por comas (`,`).
     - Los campos están entre comillas dobles (`"`).
     - Se ignora la primera línea (encabezado).
     - Las columnas son: `username`, `password`, `name`, `lastname`, `email`, `birth_date`, `customer_type_id`, `phone`.

5. **Ejecutar Procedimiento Almacenado:**
   - Se ejecuta el procedimiento almacenado `sp_reset_customers` para procesar los datos que se han cargado en la tabla temporal.

6. **Cierre de Conexión:**
   - Después de ejecutar todos los comandos, se cierra la conexión a la base de datos.

### **Consideraciones**

- **Credenciales de la Base de Datos**: Las credenciales de la base de datos se deben definir correctamente en el archivo `.env`.
- **Rutas de Archivos**: La ruta al archivo [CSV](../datos/csv/customer_temp.csv) debe ser válida y accesible desde el entorno donde se ejecute el script.
- **Errores y Excepciones**: El script maneja posibles errores de conexión, ejecución de consultas y carga de datos, con rollback en caso de fallo.
- **Configurar**: Se permite la carga de archivos locales a través de la opción `allow_local_infile`, el cual debe estar configurado.
- **Instalar**: Se debe tener instalado el ambiente adecuado y entre otros el paquete `mysql-connector-python` para ejecutar este script; Consulte [requerimientos](../scripts/python/requirements.txt).
