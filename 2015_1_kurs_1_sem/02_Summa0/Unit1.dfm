object Form1: TForm1
  Left = 301
  Top = 212
  Width = 597
  Height = 400
  Caption = 'Summa'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object GroupBox1: TGroupBox
    Left = 24
    Top = 24
    Width = 129
    Height = 81
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1061': '
    TabOrder = 0
    object edt_X: TEdit
      Left = 16
      Top = 32
      Width = 97
      Height = 28
      TabOrder = 0
      Text = '2'
    end
  end
  object GroupBox2: TGroupBox
    Left = 160
    Top = 24
    Width = 177
    Height = 81
    Caption = #1050#1086#1083'-'#1074#1086' '#1089#1083#1072#1075#1072#1077#1084#1099#1093', N: '
    TabOrder = 1
    object edt_N: TEdit
      Left = 16
      Top = 32
      Width = 97
      Height = 28
      TabOrder = 0
      Text = '2'
    end
  end
  object GroupBox3: TGroupBox
    Left = 344
    Top = 24
    Width = 129
    Height = 81
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077' E: '
    TabOrder = 2
    object edt_E: TEdit
      Left = 16
      Top = 32
      Width = 97
      Height = 28
      TabOrder = 0
      Text = '2'
    end
  end
  object mmo_Result: TMemo
    Left = 24
    Top = 112
    Width = 529
    Height = 241
    TabOrder = 3
  end
  object btn_OK: TButton
    Left = 480
    Top = 32
    Width = 73
    Height = 73
    Caption = 'OK'
    TabOrder = 4
    OnClick = btn_OKClick
  end
end
