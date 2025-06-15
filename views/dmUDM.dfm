object uDM: TuDM
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'Port=3308'
      'User_Name=dev'
      'Password=dev123'
      'Database=motel_manager'
      'DriverID=MySQL')
    Connected = True
    Left = 152
    Top = 112
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    DriverID = 'MySQL'
    Left = 240
    Top = 128
  end
end
