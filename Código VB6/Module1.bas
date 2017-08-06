Attribute VB_Name = "Module1"
Option Explicit

' Inicio de Variables para el tiempo en min y seg.
Public GreenM As String
Public YellowM As String
Public RedM As String

Public GreenS As String
Public YellowS As String
Public RedS As String

' Inicio de Variables para el tiempo en millis
Public GreenDuration As Long
Public YellowDuration As Long
Public RedDuration As Long

'Inicio de Variables para el envío
Public GreenSend As String
Public YellowSend As String
Public RedSend As String

'Inicio de Variables para botones

Public StartButton As String
Public PauseButton As String
Public StopButton As String


'ON TOP
Public Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, _
ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Public Const HWND_TOPMOST = -1
Public Const HWND_NOTOPMOST = -2
Public Const SWP_NOMOVE = &H2
Public Const SWP_NOSIZE = &H1

' Local variables used in controlling fade in/out...
Public StartValue As Long
Public EndValue As Long
Public Increment As Long
Public CurrentState As Long

Public Const Opaque As Long = 255
Public Const Transparent As Long = 5
Public Const Invisible As Long = 0

