# Proyecto 3: Reproductor de Música en Flutter

---

## 1. Objetivo del Proyecto
Diseñar y construir una aplicación de reproducción de audio móvil e interactiva utilizando el framework de Flutter y el lenguaje Dart. El enfoque principal se centra en el dominio de la programación reactiva asíncrona, la manipulación de flujos de datos continuos (`Streams`) en tiempo real y el consumo de APIs multimedia nativas del sistema operativo.

## 2. Problema que Resuelve
Sustituye las interfaces estáticas tradicionales por una arquitectura completamente reactiva. Resuelve el problema técnico de mantener sincronizada de manera milimétrica (milisegundo a milisegundo) la barra de progreso de la interfaz (`SeekBar`) con el estado del almacenamiento en búfer, la posición actual de la pista y la duración total del archivo procesado por el chip de sonido, evitando congelar la interfaz de usuario o sobrecargar el procesador con llamadas cíclicas innecesarias.

## 3. Tecnologías Utilizadas
* **Flutter SDK:** Framework declarativo utilizado para estructurar los layouts, los controles multimedia y el renderizado estético de la aplicación.
* **Dart Language:** Lenguaje base empleado para codificar la lógica asíncrona, el manejo de concurrencia y la manipulación de estructuras de datos reactivas.
* **Visual Studio Code:** Entorno de Desarrollo Integrado (IDE) utilizado junto con sus extensiones oficiales para la programación, análisis estático de dependencias y depuración del flujo asíncrono.
* **just_audio (Plugin):** Componente avanzado que proporciona la API multimedia para comunicarse con el hardware de sonido nativo y gestionar métodos de control clave.
* **rxdart (Package):** Extensión de programación reactiva utilizada para unificar múltiples flujos de datos aislados en un solo flujo compuesto.

## 4. Conceptos Aplicados
* **Programación Reactiva y Streams:** Uso riguroso de `StreamBuilder<T>` para escuchar eventos dinámicos y actualizar exclusivamente los componentes visuales de progreso, eliminando por completo el uso excesivo de `setState()` en toda la pantalla.
* **Combinación de Flujos Asíncronos:** Implementación del operador `Rx.combineLatest3` para fusionar las transmisiones en tiempo real de la posición actual, la posición cargada en búfer y la duración total del audio en un objeto de datos unificado (`PositionData`).
* **Inyección de Assets Locales:** Configuración y mapeo estructurado de dependencias de archivos locales en el archivo `pubspec.yaml`, permitiendo la precarga e indexación física de las pistas de audio (`.mp3`) y carátulas de álbumes (`.jpg`).

## 5. Capturas de Pantalla

* **1. Primera Canción:** Estado inicial del widget al cargar de forma asíncrona la primera pista de audio local con su respectiva portada y metadatos en pantalla.  
  ![Primera Canción](./capturas/primera_cancion.png)

* **2. Primera Canción Reproduciendo:** Evidencia del reproductor en ejecución activa; la barra de progreso avanza fluidamente y los controles cambian dinámicamente de estado mediante streams reactivos.  
  ![Primera Canción Reproduciendo](./capturas/primera_cancion_reproduciendo.png)

* **3. Segunda Canción:** Demostración del cambio de pista multimedia dentro de la interfaz, cargando los nuevos recursos gráficos y de audio correspondientes.  
  ![Segunda Canción](./capturas/segunda_cancion.png)

* **4. Segunda Canción Reproduciendo:** Ejecución interactiva de la segunda pista de música, validando el correcto funcionamiento de los métodos de control de hardware de audio (`.play()`, `.pause()`, `.seek()`).  
  ![Segunda Canción Reproduciendo](./capturas/segunda_cancion_reproduciendo.png)

## 6. Instrucciones de Ejecución y Despliegue

Sigue estos pasos detallados para clonar el proyecto, preparar el entorno en tu computadora local y desplegar la aplicación utilizando las interfaces de escritorio o navegadores web compatibles.

### 1. Requisitos Previos
* Tener correctamente instalado y configurado el entorno de **Flutter SDK** junto con el motor de **Dart** en las variables de entorno de tu sistema operativo.
* Contar con **Visual Studio Code** junto con las extensiones oficiales de *Flutter* y *Dart* listas para trabajar.
* Disponer de un entorno compatible para el despliegue (Google Chrome, Microsoft Edge o la configuración nativa de Windows Desktop habilitada en tu canal de Flutter).

### 2. Clonar el Proyecto
Abre una terminal de comandos en tu equipo y descarga el código fuente completo desde el repositorio oficial del portafolio ejecutando:
```
git clone [https://github.com/ObedIZ/PortafolioMoviles_AntonioObedIbarraZu-iga.git](https://github.com/ObedIZ/PortafolioMoviles_AntonioObedIbarraZu-iga.git)
```
