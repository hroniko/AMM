object Form1: TForm1
  Left = 806
  Top = 141
  Width = 526
  Height = 677
  Caption = 'Analiz(Text)'
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
    Width = 505
    Height = 241
    Caption = #1042#1072#1088#1080#1072#1085#1090' 3. '#1047#1072#1076#1072#1085#1080#1077' 3 ('#8470'16, '#1089#1090#1088'. 103)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object mmo1: TMemo
      Left = 8
      Top = 24
      Width = 489
      Height = 209
      BorderStyle = bsNone
      Color = clBtnFace
      Lines.Strings = (
        #1042' '#1079#1072#1076#1072#1085#1085#1099#1081' '#1085#1077#1087#1091#1089#1090#1086#1081' '#1090#1077#1082#1089#1090' '#1074#1093#1086#1076#1103#1090' '#1090#1086#1083#1100#1082#1086' '#1094#1080#1092#1088#1099' '#1080' '#1073#1091#1082#1074#1099'.'
        #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100', '#1091#1076#1086#1074#1083#1077#1090#1074#1086#1088#1103#1077#1090' '#1083#1080' '#1086#1085' '#1089#1083#1077#1076#1091#1102#1097#1077#1084#1091' '#1089#1074#1086#1081#1089#1090#1074#1091':'
        ''
        'a) '#1090#1077#1082#1089#1090' '#1085#1072#1095#1080#1085#1072#1077#1090#1089#1103' '#1089' '#1085#1077#1082#1086#1090#1086#1088#1086#1081' '#1085#1077#1085#1091#1083#1077#1074#1086#1081' '#1094#1080#1092#1088#1099', '#1079#1072' '
        #1082#1086#1090#1086#1088#1086#1081' '#1089#1083#1077#1076#1091#1102#1090' '#1090#1086#1083#1100#1082#1086' '#1073#1091#1082#1074#1099', '#1080' '#1080#1093' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1074#1085#1086' '
        #1095#1080#1089#1083#1086#1074#1086#1084#1091' '#1079#1085#1072#1095#1077#1085#1080#1102' '#1101#1090#1086#1081' '#1094#1080#1092#1088#1099';'
        ''
        'b) '#1090#1077#1082#1089#1090' '#1085#1072#1095#1080#1085#1072#1077#1090#1089#1103' '#1089' k '#1073#1091#1082#1074' (1<=k<=a), '#1079#1072' '#1082#1086#1090#1086#1088#1099#1084#1080' '#1089#1083#1077#1076#1091#1077#1090
        #1090#1086#1083#1100#1082#1086' '#1086#1076#1085#1072' '#1083#1080#1090#1077#1088#1072' - '#1094#1080#1092#1088#1072' '#1089' '#1095#1080#1089#1083#1086#1074#1099#1084' '#1079#1085#1072#1095#1077#1085#1080#1077#1084' k;'
        ''
        'c) '#1089#1091#1084#1084#1072' '#1095#1080#1089#1083#1086#1074#1099#1093' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1094#1080#1092#1088', '#1074#1093#1086#1076#1103#1097#1080#1093' '#1074' '#1090#1077#1082#1089#1090', '#1088#1072#1074#1085#1072
        #1076#1083#1080#1085#1077' '#1090#1077#1082#1089#1090#1072'.')
      TabOrder = 0
    end
  end
  object grp2: TGroupBox
    Left = 8
    Top = 256
    Width = 505
    Height = 185
    Caption = #1040#1085#1072#1083#1080#1079#1080#1088#1091#1077#1084#1099#1081' '#1090#1077#1082#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object btn_OK: TButton
      Left = 336
      Top = 144
      Width = 153
      Height = 33
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1072#1085#1072#1083#1080#1079'!'
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
      Width = 505
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
    Top = 448
    Width = 508
    Height = 201
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1072#1085#1072#1083#1080#1079#1072':'
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
      Width = 505
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