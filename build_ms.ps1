D:\Qt\5.15.0\msvc2019_64\bin\qmake.exe
D:\Qt\Tools\QtCreator\bin\jom.exe -j 8
Remove-Item ".\release\*.o"
Remove-Item ".\release\*.cpp"
Remove-Item ".\release\*.h"
D:\Qt\5.15.0\msvc2019_64\bin\windeployqt.exe -qmldir .\src\qml\ .\release\AM_Monitor.exe