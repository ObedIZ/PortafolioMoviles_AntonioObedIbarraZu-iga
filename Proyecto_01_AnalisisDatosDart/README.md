# Análisis de Datos con Dart

## 1. Objetivo del Proyecto
Desarrollar una aplicación de línea de comandos (CLI) interactiva en Dart que permita procesar de manera automatizada colecciones de datos estructuradas en formato JSON, realizando búsquedas, filtrados y cálculos estadísticos de forma eficiente.

## 2. Problema que Resuelve
Automatiza la lectura y el procesamiento manual de grandes volúmenes de datos de registros de personal (nombres, edades, salarios). En lugar de calcular promedios y buscar perfiles de manera tradicional, el sistema centraliza la información en un archivo local y genera reportes analíticos instantáneos sin requerir una interfaz gráfica pesada.

## 3. Tecnologías Utilizadas
* **Dart (Console SDK):** Núcleo del lenguaje para la lógica del sistema.
* **dart:io:** Librería nativa para la manipulación y persistencia de archivos en el sistema local.
* **dart:convert:** Decodificación y codificación de flujos de texto plano a objetos JSON y viceversa.

## 4. Conceptos Aplicados
* **Programación Orientada a Objetos (POO):** Modelado de datos mediante clases y abstracción de entidades.
* **Constructores Factoría (factory):** Implementación de métodos seguros de deserialización para mapear mapas clave-valor (`Map<String, dynamic>`) a instancias de clase.
* **Programación Funcional:** Uso avanzado de métodos iterativos (`.map()`, `.where()`, `.fold()`) para manipulación limpia de colecciones.
* **Null Safety:** Uso de operadores de coalescencia nula (`??`) y validaciones estrictas de tipos para evitar excepciones en tiempo de ejecución.

## 5. Capturas de Pantalla
*A continuación se muestra el funcionamiento del sistema interactivo en la terminal:*
