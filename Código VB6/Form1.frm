VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0FFFF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "CCNEM XL"
   ClientHeight    =   3930
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   8340
   ClipControls    =   0   'False
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3930
   ScaleWidth      =   8340
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2655
      Left            =   3600
      Picture         =   "Form1.frx":10CA
      ScaleHeight     =   2625
      ScaleWidth      =   4065
      TabIndex        =   10
      Top             =   480
      Width           =   4095
   End
   Begin MSCommLib.MSComm MSComm3 
      Left            =   6840
      Top             =   2640
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   3
      DTREnable       =   -1  'True
   End
   Begin VB.CommandButton To_Mini 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Minimizar"
      Height          =   375
      Left            =   1800
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   2760
      Width           =   1095
   End
   Begin VB.CommandButton Pause_Full 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      Caption         =   "Pause"
      Height          =   375
      Left            =   600
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   2760
      Width           =   1095
   End
   Begin VB.CommandButton Stop_Full 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Stop"
      Height          =   375
      Left            =   1800
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   2280
      Width           =   1095
   End
   Begin VB.CommandButton Start_Full 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Start"
      Height          =   375
      Left            =   600
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   2280
      Width           =   1095
   End
   Begin VB.TextBox RedSeg 
      Height          =   285
      Left            =   2280
      TabIndex        =   5
      Top             =   1680
      Width           =   615
   End
   Begin VB.TextBox YellowSeg 
      Height          =   285
      Left            =   2280
      TabIndex        =   4
      Top             =   1320
      Width           =   615
   End
   Begin VB.TextBox GreenSeg 
      Height          =   285
      Left            =   2280
      TabIndex        =   3
      Top             =   960
      Width           =   615
   End
   Begin VB.TextBox GreenMin 
      Height          =   285
      Left            =   1440
      TabIndex        =   2
      Top             =   960
      Width           =   615
   End
   Begin VB.TextBox RedMin 
      Height          =   285
      Left            =   1440
      TabIndex        =   1
      Top             =   1680
      Width           =   615
   End
   Begin VB.TextBox YellowMin 
      Height          =   285
      Left            =   1440
      TabIndex        =   0
      Top             =   1320
      Width           =   615
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   ":"
      Height          =   195
      Left            =   2160
      TabIndex        =   18
      Top             =   1680
      Width           =   45
   End
   Begin VB.Label Label7 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   ":"
      Height          =   195
      Left            =   2160
      TabIndex        =   17
      Top             =   1320
      Width           =   45
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   ":"
      Height          =   195
      Left            =   2160
      TabIndex        =   16
      Top             =   960
      Width           =   45
   End
   Begin VB.Label Label5 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Luz Roja"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   480
      TabIndex        =   15
      Top             =   1680
      Width           =   630
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Luz Amarilla"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   480
      TabIndex        =   14
      Top             =   1320
      Width           =   840
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Luz Verde"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   480
      TabIndex        =   13
      Top             =   960
      Width           =   720
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Min."
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   1560
      TabIndex        =   12
      Top             =   600
      Width           =   300
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Seg."
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   2400
      TabIndex        =   11
      Top             =   600
      Width           =   330
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Load()

' Apertura del Puerto Serial
MSComm3.PortOpen = True


End Sub




Private Sub Start_Full_Click()

'El tiempo será ingresado en minutos o segundos y transformado a segundos para ser utilizable en Arduino
GreenM = Val(GreenMin.Text)
YellowM = Val(YellowMin.Text)
RedM = Val(RedMin.Text)

GreenS = Val(GreenSeg.Text)
YellowS = Val(YellowSeg.Text)
RedS = Val(RedSeg.Text)


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
MSComm3.Output = GreenSend
MSComm3.Output = YellowSend
MSComm3.Output = RedSend
MSComm3.Output = StartButton
End Sub

Private Sub Pause_Full_Click()
    If Pause_Full.Caption = "Pause" Then
        PauseButton = "C$0X"
        Pause_Full.Caption = "Continue"
        Form2.Pause_Mini.Picture = Form2.Image_Continue.Picture
    ElseIf Pause_Full.Caption = "Continue" Then
        PauseButton = "C$1X"
        Pause_Full.Caption = "Pause"
        Form2.Pause_Mini.Picture = Form2.Image_Pause.Picture
    End If

MSComm3.Output = PauseButton

End Sub


Private Sub Stop_Full_Click()
StopButton = "C#1X"
MSComm3.Output = StopButton

End Sub

Private Sub To_Mini_Click()

Form2.Visible = True
Form1.Visible = False


End Sub
