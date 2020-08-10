D:\Qt\5.15.0\mingw81_64\bin\qmake.exe #Specify the path for qmake (Qt\{version}\bin\qmake.exe)
D:\Qt\Tools\mingw810_64\bin\mingw32-make.exe #Specify the path for make
Remove-Item ".\release\*.o"
Remove-Item ".\release\*.cpp"
Remove-Item ".\release\*.h"
D:\Qt\5.15.0\mingw81_64\bin\windeployqt.exe -qmldir .\src\qml\ .\release\AM_Monitor.exe #Specify the path for windeployqt(Qt\{version}\bin\windeployqt.exe) 
Compress-Archive -Path "D:\dev\AM-Monitor\release\*" -DestinationPath "D:\dev\AM-Monitor\release.zip"