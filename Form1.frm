VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Finite State Machine for hyphenation in Turkish."
   ClientHeight    =   9255
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13425
   LinkTopic       =   "Form1"
   Picture         =   "Form1.frx":0000
   ScaleHeight     =   9255
   ScaleWidth      =   13425
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   4920
      TabIndex        =   2
      Top             =   120
      Width           =   4815
   End
   Begin VB.CommandButton Command1 
      Caption         =   "-> Hecele ->"
      Height          =   375
      Left            =   3720
      TabIndex        =   1
      Top             =   120
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   405
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3375
   End
   Begin VB.Label Label1 
      BackColor       =   &H80000005&
      Height          =   375
      Left            =   9960
      TabIndex        =   3
      Top             =   120
      Width           =   3255
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Copyright (C) 2003 Suhan DUMAN (suhan@turkserve.net)
'The original algorithm is generated by Engin Gunduz in Perl.
'This program is free software; you can redistribute it and/or modify it.


Private Sub Command1_Click()
Text2.Text = hecelereBol(Text1.Text)
End Sub

Function hecelereBol(kelime As String)
    
    sesliler = "aeýioöuü"
    sessizler = "bcçdfgðhjklmnprsþtvyz"
    Dim dizilis, durum, heceler, c As String
    Dim uzunluk, j As Integer
    dizilis = ""
    durum = ""
    heceler = ""
    j = 1
    uzunluk = Len(kelime)
    
    
    For i = 1 To uzunluk
        c = Mid(kelime, i, 1)
        If InStr(1, sesliler, c) > 0 Then
            dizilis = dizilis + "o"
        End If
        If InStr(1, sessizler, c) > 0 Then
            dizilis = dizilis + "X"
        End If
    Next i
    
    Label1.Caption = "Dizilis Sekli : " + dizilis
    
    
    durum = "DURUM_NULL"
    
    Do While j <= Len(dizilis)
        
        If durum = "DURUM_NULL" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_o"
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_X"
                If j > Len(dizilis) Then
                    Label1.Caption = "Hata : " + dizilis
                    hecelereBol = "Hata"
                End If
            End If
        End If
        
        
        
        If durum = "DURUM_X" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_Xo"
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_XX"
                If j > Len(dizilis) Then
                    Label1.Caption = "Hata : " + dizilis
                    hecelereBol = "Hata"
                End If
            End If
        End If
        
        
        
        If durum = "DURUM_XX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_XXo"
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 3, 1) + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                Label1.Caption = "Hata : " + dizilis
                hecelereBol = "Hata"
            End If
        End If
        
        
        If durum = "DURUM_XXo" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_o"
                heceler = heceler + "_" + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1) + Mid(kelime, j - 2, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_XXoX"
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1) + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            End If
        End If
        
        
        
        
        If durum = "DURUM_XXoX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_Xo"
                heceler = heceler + "_" + Mid(kelime, j - 5, 1) + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_XXoXX"
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 5, 1) + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1) + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            End If
        End If
        
        
        
        
        If durum = "DURUM_XXoXX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_Xo"
                heceler = heceler + "_" + Mid(kelime, j - 6, 1) + Mid(kelime, j - 5, 1) + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_XXoXXX"
                If j > Len(dizilis) Then
                    Label1.Caption = "Hata : " + dizilis
                    hecelereBol = "Hata"
                End If
            End If
        End If
        
        
        
        If durum = "DURUM_XXoXXX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_Xo"
                heceler = heceler + "_" + Mid(kelime, j - 7, 1) + Mid(kelime, j - 6, 1) + Mid(kelime, j - 5, 1) + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_XX"
                heceler = heceler + "_" + Mid(kelime, j - 7, 1) + Mid(kelime, j - 6, 1) + Mid(kelime, j - 5, 1) + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1)
                If j > Len(dizilis) Then
                    Label1.Caption = "Hata : " + dizilis
                    hecelereBol = "Hata"
                End If
            End If
        End If
        
        
        
        If durum = "DURUM_Xo" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_o"
                heceler = heceler + "_" + Mid(kelime, j - 3, 1) + Mid(kelime, j - 2, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_XoX"
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 3, 1) + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            End If
        End If
        
        
        
        
        If durum = "DURUM_XoX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_Xo"
                heceler = heceler + "_" + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_XoXX"
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1) + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            End If
        End If
        
        
        
        If durum = "DURUM_XoXX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_Xo"
                heceler = heceler + "_" + Mid(kelime, j - 5, 1) + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_XoXXX"
                If j > Len(dizilis) Then
                    Label1.Caption = "Hata : " + dizilis
                    hecelereBol = "Hata"
                End If
            End If
        End If
        
        
        
        
        If durum = "DURUM_XoXXX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_Xo"
                heceler = heceler + "_" + Mid(kelime, j - 6, 1) + Mid(kelime, j - 5, 1) + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                Label1.Caption = "Hata : " + dizilis
                hecelereBol = "Hata"
            End If
        End If
        
        
        
        If durum = "DURUM_o" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_o"
                heceler = heceler + "_" + Mid(kelime, j - 2, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_oX"
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            End If
        End If
        
        
        
        If durum = "DURUM_oX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_Xo"
                heceler = heceler + "_" + Mid(kelime, j - 3, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_oXX"
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 3, 1) + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            End If
        End If
        
        
        
        
        If durum = "DURUM_oXX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_Xo"
                heceler = heceler + "_" + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_oXXX"
                If j > Len(dizilis) Then
                    Label1.Caption = "Hata : " + dizilis
                    hecelereBol = "Hata"
                End If
            End If
        End If
        
        
        
        If durum = "DURUM_oXXX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_Xo"
                heceler = heceler + "_" + Mid(kelime, j - 5, 1) + Mid(kelime, j - 4, 1) + Mid(kelime, j - 3, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                durum = "DURUM_oXXXX"
                If j > Len(dizilis) Then
                    Label1.Caption = "Hata : " + dizilis
                    hecelereBol = "Hata"
                End If
            End If
        End If
        
        
        
        If durum = "DURUM_oXXXX" Then
            If Mid(dizilis, j, 1) = "o" Then
                j = j + 1
                durum = "DURUM_XXo"
                heceler = heceler + "_" + Mid(kelime, j - 6, 1) + Mid(kelime, j - 5, 1) + Mid(kelime, j - 4, 1)
                If j > Len(dizilis) Then
                    heceler = heceler + "_" + Mid(kelime, j - 3, 1) + Mid(kelime, j - 2, 1) + Mid(kelime, j - 1, 1)
                    Exit Do
                End If
            Else
                j = j + 1
                Label1.Caption = "Hata : " + dizilis
                hecelereBol = "Hata"
            End If
        End If
        
        
    Loop
    
    hecelereBol = Mid(heceler, 2)
End Function
