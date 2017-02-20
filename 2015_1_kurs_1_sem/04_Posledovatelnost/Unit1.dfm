object Form1: TForm1
  Left = 511
  Top = 251
  Width = 429
  Height = 586
  Caption = 'Posledovatelnost(MinMax)'
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
    Height = 137
    Caption = #1042#1072#1088#1080#1072#1085#1090' 3. '#1047#1072#1076#1072#1085#1080#1077' 4 ('#8470'52, '#1089#1090#1088'. 145)'
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
      Height = 105
      BorderStyle = bsNone
      Color = clBtnFace
      Lines.Strings = (
        #1044#1072#1085#1072' '#1087#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1080#1079' N '#1089#1080#1084#1074#1086#1083#1086#1074'.'
        #1059#1084#1077#1085#1100#1096#1080#1090#1100' '#1077#1077', '#1091#1076#1072#1083#1080#1074' '#1074#1089#1077' '#1084#1080#1085#1080#1084#1072#1083#1100#1085#1099#1077' '#1080
        #1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1099#1077' '#1101#1083#1077#1084#1077#1085#1090#1099' '#1080' '#1089#1076#1074#1080#1085#1091#1074' '#1074#1089#1077' '
        #1086#1089#1090#1072#1083#1100#1085#1099#1077' '#1082' '#1085#1072#1095#1072#1083#1091' '#1087#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086#1089#1090#1080'.'
        ''
        '('#1055#1088#1080#1084#1077#1088': 12341234 -> 2323 )')
      TabOrder = 0
    end
  end
  object grp2: TGroupBox
    Left = 8
    Top = 152
    Width = 401
    Height = 185
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1080#1079' N '#1089#1080#1084#1074#1086#1083#1086#1074':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object btn_OK: TButton
      Left = 248
      Top = 144
      Width = 137
      Height = 33
      Caption = #1060#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1090#1100
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
    Top = 344
    Width = 404
    Height = 201
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
      Height = 161
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
