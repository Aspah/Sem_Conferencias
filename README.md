# Sem_Conferencias
Semáforo para la regulación del tiempo de las Conferencias realizadas durante el XL Congreso Científico Nacional de Estudiantes de Medicina, Chile. https://www.ccnem.cl

Consiste en un semáforo de tres luces (verde, amarilla y roja) que informa al expositor el tiempo restante para el desarrollo de su conferencia. 

Arquitectura: 
  1.- Interfaz Gráfica
  2.- Código de Control 
  

1/  Interfaz Gráfica 
Interfaz diseñada para el Sistema Operativo Windows 10, sobre la plataforma Microsoft Visual Basic 6.0. 
Recibe como Input los tiempos de duración para cada una de las luces y eventos de control (Start, Stop, Pause, Continue). 
Envía como Output, un código con la información correspondiente a través de comunicación serial, hacia una placa Arduino UNO, quien controla el funcionamiento de las luces. 

2/ Código de Control 
Código diseñado para Arduino UNO.
Recibe como Input, los enviados desde la Interfaz Gráfica a través de comunicación Serial. 
Como Output, ejecuta el control de encendido o apagado de cada uno de los tres LED
