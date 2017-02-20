object Form1: TForm1
  Left = 511
  Top = 251
  Width = 429
  Height = 586
  Caption = 'Matrix(SummCifr)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 20
  object grp1: TGroupBox
    Left = 8
    Top = 8
    Width = 401
    Height = 97
    Caption = #1042#1072#1088#1080#1072#1085#1090' 3. '#1047#1072#1076#1072#1085#1080#1077' 5 ('#8470'35)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object mmo1: TMemo
      Left = 16
      Top = 24
      Width = 369
      Height = 65
      BorderStyle = bsNone
      Color = clBtnFace
      Lines.Strings = (
        #1044#1072#1085#1072'  '#1087#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1072#1103'  '#1084#1072#1090#1088#1080#1094#1072' A [ n x m ],'
        #1101#1083#1077#1084#1077#1085#1090#1072#1084#1080' '#1082#1086#1090#1086#1088#1086#1081' '#1103#1074#1083#1103#1102#1090#1089#1103' '#1094#1077#1083#1099#1077' '#1095#1080#1089#1083#1072'.'
        #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1076#1083#1103' '#1082#1072#1078#1076#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1087#1086#1079#1080#1094#1080#1080
        #1101#1083#1077#1084#1077#1085#1090#1086#1074' '#1084#1072#1090#1088#1080#1094#1099' '#1089' '#1090#1072#1082#1086#1081' '#1078#1077' '#1089#1091#1084#1084#1086#1081' '#1094#1080#1092#1088'.')
      TabOrder = 0
    end
  end
  object grp2: TGroupBox
    Left = 8
    Top = 112
    Width = 401
    Height = 185
    Caption = #1069#1083#1077#1084#1077#1085#1090#1099' '#1084#1072#1090#1088#1080#1094#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object btn_OK: TButton
      Left = 288
      Top = 144
      Width = 97
      Height = 33
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btn_OKClick
    end
    object mmo_Input: TMemo
      Left = 0
      Top = 24
      Width = 401
      Height = 113
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object grp3: TGroupBox
    Left = 5
    Top = 304
    Width = 404
    Height = 241
    Caption = #1056#1077#1079#1091#1083#1100#1090#1080#1088#1091#1102#1097#1072#1103' '#1087#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086#1089#1090#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object mmo_Output: TMemo
      Left = 0
      Top = 24
      Width = 404
      Height = 209
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
