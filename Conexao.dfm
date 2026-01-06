object DataModule1: TDataModule1
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Gabriel\Desktop\TesteUnitarios\BancoTeste30\TE' +
        'STE30.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3060'
      'SQLDialect='
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'DriverID=FB')
    Left = 160
    Top = 160
  end
  object FDQuery1: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 344
    Top = 144
  end
end
