# CREACION DE BASE DE DATOS

## "miChangarro" TIENDA DEPARTAMENTAL.

Regresar a readme: [click aquí](../readme.md).
 

### Problematica:
 "miChangarro" es una tienda departamental ficticia, que desea tener una base de datos robusta y eficiente. Esta base de datos debe permitir la gestión interna de su inventario de ventas; conocer las preferencias de los clientes ofreciendo múltiples opciones de compra, sin entorpecer las mismas y administrar los totales de ventas por cliente, departamento,mes, etc.
 
 Desglose de Problemas:
 1. Gestión de Clientes: Necesitamos una base de datos que permita registrar la información de los clientes, sus métodos de pago, preferencias y posibles descuentos por tipo de cliente.
 2. Gestión de Empleados: registran y actualizan el inventario, gestionan información de departamentos de tienda y en general actualizan la información del sistema.
 3. Seguridad en las transacciones: La base de datos debe permitirle al negocio poder dar detalles e informes sobre las ventas con datos en línea para toma de decisiones.

### Solución Propuesta:
 
 El diseño propuesto a continuación pretende cumplir con la escalabilidad y seguridad que definen los requerimientos. Esta base de datos permite tener control sobre los artículos del almacén, gestiona datos de clientes, empleado y proporciona informes sobre monto de transacciones de ventas. 
 
 Esta base de datos aborda principalmente lo siguiente:
- Almacén: 
	+ Nombre del Articulo
	+ Precio
	+ Cantidad de Artículos en almacén
	+ Descuento del producto 
	+ Departamento al que pertenece.
- Departamentos
	+ Nombre del departamento
	+ Subdepartamentos
	+ Descripciones de los mismos.
	
- Gestión de Clientes:
	+ Datos Generales
	+ ¿Que compran los Clientes?
	+ Tipos de clientes
	+ Descuentos por lealtad o tipo de cliente.
	+ Métodos de pago del cliente. (Esto gestionado por los empleados)
	
- Ventas: Información de las Ventas
	+ Artículos vendidos
	+ ¿Quien los compra?
	+ ¿Con que los compra?
	+ ¿Cuantos Artículos compra?
	+ ¿Que departamento vende más?

### Funcionalidades Clave

__Gestión de Clientes__: Almacena datos de clientes y sus preferencias, facilitando la aplicación de descuentos.

__Gestión de Empleados__: Controla el acceso a datos e información sobre inventarios y ventas.

__Ventas__: Registra las transacciones, permitiendo analizar el rendimiento por departamento y por cliente.

__Seguridad en Transacciones__: Registro detallado de cada venta, permitiendo auditorías y análisis en tiempo real.

En resumen esta base de datos mejorara la precisión, eficiencia, seguridad y capacidad de toma de decisiones en la gestión la tienda.
 
 ### Conclusión
 
Este diseño de base de datos es escalable y seguro, permitiendo que "miChangarro" gestione eficazmente sus operaciones diarias, realice un seguimiento de las preferencias de los clientes y genere informes útiles para la toma de decisiones.
 
