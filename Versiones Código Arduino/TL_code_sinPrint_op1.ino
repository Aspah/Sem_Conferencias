//Conference Light

/*VERSIÓN 1: El semáforo completa su ciclo y parpadea en tres grupos de a tres
parpadeos para informar el fin del tiempo */

/* Este proyecto programa un Arduino para controlar un Semáforo de Conferencias,
que indicará al expositor cuanto tiempo le queda para completar su exposición.
Comprende tres luces (Verde, Amerillo y Rojo) con un orden secuencial
de encendido [V -> A -> R], con la posibilidad de Pausar y/o Detener esta secuencia

El manejo de este semáforo se hace desde una GUI de un programa.exe para Windows 10
creado en Microsof VisualBasic 6.0 y que se comunica con el Arduino a través de un USB físico
usado como puerto serial

Esta GUI posee, en general, dos secciones:
- Campos para ingresar la duración de cada luz
- Botones de control [Start, Pause, Stop]
Cada vez que un botón es presionado, se envía data a través del puerto serial */


/*Explicación sobre como es eviada la data a través del Serial Port.

Se necesitan enviar dos tipos de Datos:
- Duración de cada luz encendida
- Botones de Control.

Estructura General del Dato:

                            << DG12345X >> / << C$0X >>

1° carácter -> Identificador del tipo de dato Duración <D> o Control <C>
2° carácter -> ID de cada luz o cada botón.

Siguientes n carácteres: Valor del dato: 1/0 para botones de control; n° de
                        segundos, para duración de encendido.
Último carácter: Siempre es <X>
                Indica que el dato presente finalizó y que el siguiente carácter
                corresponde al siguiente dato.

Estructura Dato Duración de Encendido:

                            << DG12345X >>

1° carácter -> Identificador <D> (Duración)
2° carácter -> ID de la luz a la que corresponde el dato:
                ID = [Green: <G>; Yellow: <Y>; Red: <R> ]
n carácter  -> Duración en segundos de la luz encendida.
Último carácter ->  <X> (Fin del Dato)

Estructura Dato Botón de Control:

                            << C@1X >>

1° carácter -> Identificador <C> (Control)
2° carácter -> ID del botón alque corresponde el dato:
                ID = [Start: <@>; Pause: <$>; Stop: <#>]
3° carácter  ->
              En el caso de:
               Start: <1> : "Comenzar" -  <0> "No Comenzar"
               Stop:  <1> : "Detener"  -  <0> "No Detener"
               Pause: <0>: "Pausar"    -  <1> "No pausar"

¡¡ATENCIÓN!!, por motivos prácticos, el botón pause está configurado al revés
que la convención << 1: True / 0: False >>


4° carácter ->  <X> (Fin del Dato)
*/


//===========================================================================
//=====================INICIO DEL CÓDIGO=====================================
//===========================================================================


String duration_value;
String control_value;
String package_value;

String GreenDuration;
String YellowDuration;
String RedDuration;
unsigned long Green_int;
unsigned long Yellow_int;
unsigned long Red_int;

String StartButton = "0";
String PauseButton = "1";
String StopButton = "0";
char carrier;
unsigned long time_clock = 0;

int greenPin = 4;
int yellowPin = 5;
int redPin = 6;


#include "TimerOne.h"

void setup()
{
  Serial.begin(9600);
  Timer1.initialize(1000000); // Inicialización del Timer1, Período = 1 seg. = 1000000 microsecond)
  Timer1.attachInterrupt(Timer);
  pinMode(redPin, OUTPUT);
  pinMode(yellowPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
}

void Timer()
{
  if (StartButton == "1")
  {
    int increase = PauseButton.toInt();
    time_clock = time_clock + increase;
    if (StopButton == "1")
    {
      time_clock = 0;
      StartButton = "0";
      PauseButton = "1";
      StopButton = "0";
    }
    //Serial.print(increase); Serial.print(" ; "); Serial.println(time_clock);
  }
}

void loop()
{
  get_package();
  manage_package();
  TrafficLight();
  //delay(5000);
}

//=================== INICIO DEL PROGRAMA(MANEJO DE LA DATA)====================

void get_package()
{ //RECEPCIÓN DEL PAQUETE. CHARACTER 'X' COMO SEPARADOR
  if (Serial.available() > 0  )
  {
    package_value = Serial.readStringUntil('X');
    //Serial.print(package_value); Serial.println("; pack_value");
  }
}

void manage_package()
{ //MANEJO DEL PAQUETE. PRIMERO IDENTIFICA DURACIÓN O CONTROL
  //LUEGO CLASIFICA ENTRE TIPO DE LUZ O CONTROL
  ident_package();
  class_package();
}


void ident_package()
{ // IDENTIFICA ENTRE DURACIÓN O LUZ
  if (package_value.startsWith("D", 0))
  {
    //Serial.println("ident_pack D, OK");
    duration_value = package_value.substring(1);
    //Serial.print(duration_value); Serial.println("; dur_value");
  }
  else if (package_value.startsWith("C", 0))
  {
    //Serial.println("ident_pack C, OK" );
    control_value = package_value.substring(1);
    //Serial.print(control_value); Serial.println("; ctrl_value");
  }
}

void class_package()
{
  //CLASIFICACIÓN POR LUZ
  if (duration_value.startsWith("G", 0))
  {
    //Serial.println("class_pack G, OK");
    GreenDuration = duration_value.substring(1);
    Green_int = GreenDuration.toInt();
    //Serial.print(GreenDuration); Serial.println("; GreenDuration");
  }
  else if (duration_value.startsWith("Y", 0))
  {
    //Serial.println("class_pack Y, OK");
    YellowDuration = duration_value.substring(1);
    Yellow_int = YellowDuration.toInt();
    //Serial.print(YellowDuration); Serial.println("; YellowDuration");
  }
  else if (duration_value.startsWith("R", 0))
  {
    //Serial.println("class_pack R, OK");
    RedDuration = duration_value.substring(1);
    Red_int = RedDuration.toInt();
    //Serial.print(RedDuration); Serial.println("; RedDuration");
  }
  //CLASIFICACIÓN POR TIPO DE CONTROL
  if (control_value.startsWith("@", 0))
  {
    //Serial.println("class_ctrl @, OK");
    StartButton = control_value.substring(1);
    //Serial.print(StartButton); Serial.println("; StartButton");
  }
  else if (control_value.startsWith("$", 0))
  {
    //Serial.println("class_ctrl $, OK");
    PauseButton = control_value.substring(1);
    //Serial.print(PauseButton); Serial.println("; PauseButton");
  }
  else if (control_value.startsWith("#", 0))
  {
    //Serial.println("class_ctrl #, OK");
    StopButton = control_value.substring(1);
    //Serial.print(StopButton); Serial.println("; StopButton");
  }
}

//=====================MANEJO DEL SEMÁFORO===================================

void TrafficLight()
{
//TimePoints

  unsigned long T0 = 0;
  unsigned long T1 = Green_int;
  unsigned long T2 = T1 + Yellow_int;
  unsigned long T3 = T2 + Red_int;

  if ( (T0 < time_clock ) && ( time_clock <= T1))
  {
    //Serial.println("Green ON, by code");
    digitalWrite(greenPin,HIGH);
    digitalWrite(yellowPin,LOW);
    digitalWrite(redPin, LOW);
  }
  else if  ((T1 < time_clock) && (time_clock <= T2))
  {
    //Serial.println("Yellow ON, by code");
    digitalWrite(greenPin, LOW);
    digitalWrite(yellowPin, HIGH);
    digitalWrite(redPin, LOW);
  }
  else if ((T2 < time_clock) && (time_clock <= T3))
  {
    //Serial.println("Red ON, by code");
    digitalWrite(greenPin, LOW);
    digitalWrite(yellowPin, LOW);
    digitalWrite(redPin, HIGH);
  }
  else if (time_clock == (T3 + 1))
  {
    for(int x = 0; x < 3 ; x++)
    {
      for(int i = 0; i < 3 ; i++)
      {
        digitalWrite(greenPin, LOW);
        digitalWrite(yellowPin, LOW);
        digitalWrite(redPin, LOW);
        delay(500);
        digitalWrite(greenPin, HIGH);
        digitalWrite(yellowPin, HIGH);
        digitalWrite(redPin, HIGH);
        delay(100);
      }
      delay(500);
    }
  }
  else
  {
    //Serial.println("Sobre T3");
    digitalWrite(greenPin, LOW);
    digitalWrite(yellowPin,LOW);
    digitalWrite(redPin, LOW);
  }
}
