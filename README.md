# esqueleto\_aplicacion\_new 

\# Esqueleto\_Aplicacion\_New



\##Descripción general del proyecto

\*\*Esqueleto\_Aplicacion\_New\*\* es una aplicación móvil diseñada para recibir \*\*comandos por voz o mediante botones\*\* con el fin de \*\*controlar un exoesqueleto robótico\*\*.  

La app permite seleccionar y enviar rutinas de movimiento de manera remota, proporcionando una \*\*interfaz accesible e intuitiva\*\* para los usuarios y terapeutas.



---



\##  Objetivo y contexto

El objetivo principal del proyecto es \*\*establecer una comunicación confiable entre la aplicación móvil y el exoesqueleto\*\*, enviando rutinas o comandos que guíen los movimientos del paciente durante su terapia física.



Este desarrollo forma parte del \*\*proyecto de robótica aplicada a rehabilitación motriz\*\*, dentro del laboratorio dirigido por el \*\*Dr. Hipólito Aguilar Sierra\*\*.  

Está orientado a \*\*mejorar la autonomía y calidad de vida de pacientes\*\* que requieren asistencia en procesos de recuperación motora.



---



\##  Requerimientos de hardware y software



\###  Hardware

\- Teléfono Android (versión recomendada: \*\*Android 9.0 o superior\*\*)  

\- Cable \*\*USB\*\* para conexión con el equipo de desarrollo  

\- \*\*Exoesqueleto\*\* compatible con el protocolo de comunicación definido  



\###  Software

\- \*\*Sistema operativo:\*\* Windows 10 o superior  

\- \*\*IDE recomendado:\*\* Visual Studio Code o Android Studio  

\- \*\*SDK:\*\* Android SDK nivel 29 o superior  

\- \*\*Lenguaje:\*\* Dart / Flutter  

\- \*\*Dependencias principales:\*\*

&nbsp; - `speech\_to\_text` → Reconocimiento de voz  

&nbsp; - `bluetooth` o `wifi` → Comunicación con el exoesqueleto



---



\##  Instrucciones de instalación y ejecución

.



1\. \*\*Clonar el repositorio o descargar el proyecto.\*\*

&nbsp;  ```bash

&nbsp;  git clone https://github.com/Katham28/esqueleto\_aplicacion\_new.git



2\. Abrir el proyecto en Visual Studio Code o Android Studio.



3\. Instalar dependencias:

&nbsp;   ```bash

&nbsp;   flutter pub get



4.-Conceder permisos de micrófono y Bluetooth/Wi-Fi cuando el sistema lo solicite.



NOTA: Para su ejecución es recomendable utilizar un emulador de android creado desde Android estudio o utilizar un teléfono android, activarle el modo desarrollador y conectarlo a la computadora por usb, seleccionando en el IDE el nombre del dispositivo

La estructura principal del proyecto es:
/lib  contiene Código fuente
/assets  Imágenes, íconos
/doc documentacion extra del sitema


Créditos y autores





Desarrolladores:



Katia Marcela Carpio Domínguez



Jorge Sánchez Girón



Responsable del proyecto:



Dr. Hipólito Aguilar Sierra



