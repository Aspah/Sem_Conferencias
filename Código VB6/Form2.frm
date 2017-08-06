VERSION 5.00
Begin VB.Form Form2 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Form2"
   ClientHeight    =   420
   ClientLeft      =   10005
   ClientTop       =   0
   ClientWidth     =   1920
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   420
   ScaleWidth      =   1920
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Image_Continue 
      Caption         =   "Image_Continue"
      Height          =   615
      Left            =   2640
      Picture         =   "Form2.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   2160
      Width           =   1695
   End
   Begin VB.CommandButton Image_Pause 
      Caption         =   "Image_Pause"
      Height          =   615
      Left            =   3000
      Picture         =   "Form2.frx":0932
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   1320
      Width           =   1335
   End
   Begin VB.CommandButton To_Full 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0FFFF&
      Height          =   435
      Left            =   1440
      Picture         =   "Form2.frx":12CC
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   0
      Width           =   495
   End
   Begin VB.CommandButton Stop_Mini 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0FFFF&
      Height          =   435
      Left            =   960
      Picture         =   "Form2.frx":15E8
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   0
      Width           =   495
   End
   Begin VB.CommandButton Pause_Mini 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0FFFF&
      Height          =   435
      Left            =   480
      Picture         =   "Form2.frx":18F5
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   0
      Width           =   495
   End
   Begin VB.CommandButton Start_Mini 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0FFFF&
      Height          =   435
      Left            =   0
      Picture         =   "Form2.frx":228F
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   0
      Width           =   495
   End
   Begin VB.Timer Timer1 
      Interval        =   20
      Left            =   120
      Top             =   2040
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
''MANEJO TRANSPARENCIA

' API declarations...
Private Const GWL_STYLE = -16
Private Const GWL_EXSTYLE = -20
Private Const LWA_COLORKEY = &H1
Private Const LWA_ALPHA = &H2
Private Const WS_EX_LAYERED = &H80000


Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function SetLayeredWindowAttributes Lib "user32" (ByVal hwnd As Long, ByVal crKey As Long, ByVal bAlpha As Byte, ByVal dwFlags As Long) As Long





''MANEJO MOUSE OVER

Private Declare Function SetCapture Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function ReleaseCapture Lib "user32" () As Long
Private Declare Function GetCapture Lib "user32" () As Long

Private Sub Form_Load()
    'ON TOP
        Call SetWindowPos(Form2.hwnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE)
    'Transparencia
        CurrentState = Opaque
End Sub


Private Sub Start_Mini_Click()

'El tiempo será ingresado en minutos o segundos y transformado a segundos para ser utilizable en Arduino
GreenM = Val(Form1.GreenMin.Text)
YellowM = Val(Form1.YellowMin.Text)
RedM = Val(Form1.RedMin.Text)

GreenS = Val(Form1.GreenSeg.Text)
YellowS = Val(Form1.YellowSeg.Text)
RedS = Val(Form1.RedSeg.Text)


'Conversión de unidades
GreenDuration = (GreenM * 60) + (GreenS)
YellowDuration = (YellowM * 60) + (YellowS)
RedDuration = (RedM * 60) + (RedS)


'Config y To Send
GreenSend = "DG" + CStr(GreenDuration) + "X"
YellowSend = "DY" + CStr(YellowDuration) + "X"
RedSend = "DR" + CStr(RedDuration) + "X"
StartButton = "C#1XC@1X"
    '-> Aquì le mando un "STOP previo al START. Así se evita cualquier problema al apretar START sin haber apretado STOP previamente


'Enviar Valores por el Puerto
Form1.MSComm3.Output = GreenSend
Form1.MSComm3.Output = YellowSend
Form1.MSComm3.Output = RedSend
Form1.MSComm3.Output = StartButton

'Transparencia
  StartValue = Opaque
  EndValue = Transparent
  Increment = -3
  Timer1.Enabled = True

End Sub

Private Sub Pause_Mini_Click()
 If Form1.Pause_Full.Caption = "Pause" Then
        PauseButton = "C$0X"
        Pause_Mini.Picture = Image_Continue.Picture
        Form1.Pause_Full.Caption = "Continue"
        
        'Transparencia
        CurrentState = Opaque
        Timer1.Enabled = False
        SetLayeredWindowAttributes Me.hwnd, 0, CurrentState, LWA_ALPHA
        
    ElseIf Form1.Pause_Full.Caption = "Continue" Then
        PauseButton = "C$1X"
        Pause_Mini.Picture = Image_Pause.Picture
        Form1.Pause_Full.Caption = "Pause"
        
        'Transparencia
        StartValue = Opaque
        EndValue = Transparent
        Increment = -3
        Timer1.Enabled = True
    End If

Form1.MSComm3.Output = PauseButton

End Sub


Private Sub Stop_Mini_Click()
StopButton = "C#1X"
Form1.MSComm3.Output = StopButton
'Transparencia
CurrentState = Opaque
Timer1.Enabled = False
SetLayeredWindowAttributes Me.hwnd, 0, CurrentState, LWA_ALPHA

End Sub

Private Sub To_Full_Click()

Form1.Visible = True
Form2.Visible = False

'Transparencia
CurrentState = Opaque
Timer1.Enabled = False
SetLayeredWindowAttributes Me.hwnd, 0, CurrentState, LWA_ALPHA

End Sub


Private Sub Start_Mini_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If (CurrentState <> Opaque) Then
        If (X < 0) Or (Y < 0) Or (X > Start_Mini.Width) Or (Y > Start_Mini.Width) Then
            ReleaseCapture
        ElseIf GetCapture() <> Start_Mini.hwnd Then
            SetCapture Start_Mini.hwnd
            CurrentState = Opaque
            'Timer1.Enabled = False
            SetLayeredWindowAttributes Me.hwnd, 0, CurrentState, LWA_ALPHA
        End If
    End If
End Sub

Private Sub Stop_Mini_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If (CurrentState <> Opaque) Then
        If (X < 0) Or (Y < 0) Or (X > Stop_Mini.Width) Or (Y > Stop_Mini.Width) Then
            ReleaseCapture
        ElseIf GetCapture() <> Stop_Mini.hwnd Then
            SetCapture Stop_Mini.hwnd
            CurrentState = Opaque
            'Timer1.Enabled = False
            SetLayeredWindowAttributes Me.hwnd, 0, CurrentState, LWA_ALPHA
        End If
    End If
End Sub

Private Sub Pause_Mini_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If (CurrentState <> Opaque) Then
        If (X < 0) Or (Y < 0) Or (X > Pause_Mini.Width) Or (Y > Pause_Mini.Width) Then
            ReleaseCapture
        ElseIf GetCapture() <> Pause_Mini.hwnd Then
            SetCapture Pause_Mini.hwnd
            CurrentState = Opaque
            'Timer1.Enabled = False
            SetLayeredWindowAttributes Me.hwnd, 0, CurrentState, LWA_ALPHA
        End If
    End If
End Sub

Private Sub Timer1_Timer()
' This is the routine which does all the work.
  ' It will increment the current "alpha" from whatever it
  ' was, until it reaches "EndValue".
  ' If that is completely invisible (zero) then also
  ' unload the form to end the application.
  
  
  Static BeenHereB4 As Boolean
  Dim lStyle As Long
  'Dim lAlpha

  
  If Not BeenHereB4 Then
    ' Only do this the first time we enter this routine.
    lStyle = GetWindowLong(Me.hwnd, GWL_EXSTYLE)
    lStyle = lStyle Or WS_EX_LAYERED
    SetWindowLong Me.hwnd, GWL_EXSTYLE, lStyle
    BeenHereB4 = True
  End If
  
  CurrentState = CurrentState + Increment
  If CurrentState < 0 Then CurrentState = 0
  If CurrentState > 255 Then CurrentState = 255
  
  'Esta secuencia es la que cambia la transparencia en cada llamada del Timer
  SetLayeredWindowAttributes Me.hwnd, 0, CurrentState, LWA_ALPHA
  
  ' If we have reached the specified limit, then
  ' beep and stop.
  If (Increment > 0 And CurrentState >= EndValue) Or (Increment < 0 And CurrentState <= EndValue) Then
    Timer1.Enabled = False
    
    ' If now completely invisible, then unload as well.
    'If EndValue = Invisible Then
      'Unload Me
    'End If
  End If
End Sub
