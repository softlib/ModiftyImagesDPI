object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #20462#25913#22270#29255#20998#36776#29575'(DPI)'#65288#25903#25345'jpg,tif,bmp)'
  ClientHeight = 242
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 25
    Width = 137
    Height = 13
    Caption = #38656#35201#20462#25913'DPI'#30340#22270#29255#36335#24452#65306
  end
  object Label2: TLabel
    Left = 248
    Top = 91
    Width = 37
    Height = 16
    Caption = 'Label2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 93
    Width = 79
    Height = 16
    Caption = #26032#30340'DPI'#20540#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 16
    Top = 56
    Width = 529
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 576
    Top = 46
    Width = 89
    Height = 41
    Caption = #24320#22987#20462#25913
    TabOrder = 1
    OnClick = Button1Click
  end
  object edtDPIValue: TEdit
    Left = 88
    Top = 88
    Width = 65
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 2
    Text = '300'
  end
  object cbOverWriteFiles: TCheckBox
    Left = 8
    Top = 129
    Width = 177
    Height = 17
    Caption = #36716#25442#21518#30340#26032#25991#20214#35206#30422#21407#25991#20214
    TabOrder = 3
  end
end
