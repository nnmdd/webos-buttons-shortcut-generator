set promptinstall=yes
@echo off
setlocal EnableExtensions enabledelayedexpansion
:m1
cls
set n=0
for /r /d %%a in (apps\*) do (
  set /a n+=1
  set "menu_!n!=%%~nxa"
  echo press !n! for %%~nxa
)
echo press 0 for exit
set /p "take=your choice: "
if "!take!"=="0" echo bb. cya. && goto :eof
set app=!menu_%take%!
if defined app set app=%app: =%
if not defined app goto m1

:m2
cls
set m=0
for /r /d %%a in (buttons\*) do (
  set /a m+=1
  set menu_!m!="%%~nxa"
  echo press !m! for %%~nxa
)
echo press 0 for exit
set /p "take=your choice: "
if "!take!"=="0" echo bb. cya. && goto :eof
set button=!menu_%take%:"=!
if defined button (
	set button3=!button:visible=!
	set button2=!button3: =!
)
if "!button2!"=="kinopoisk" set "id=com.685631.3411"
if "!button2!"=="okko" set "id=yota.play"
if "!button2!"=="movies" set "id=com.27668.188461"
if "!button2!"=="ivi" set "id=ivi"
if not defined button2 goto m2

:makeit
rd /q /s "%~dp0tmp" 2>nul
mkdir "%~dp0tmp\%button%%app%" 2>nul
del /q "%~dp0readyapps\%button% %app%.ipk" 2>nul
C:\windows\system32\robocopy.exe "%~dp0apps\%app%" "%~dp0tmp\%button%%app%" /e >nul
C:\windows\system32\robocopy.exe "%~dp0buttons\%button%" "%~dp0tmp\%button%%app%" /e >nul
call ..\ares-package.cmd "%~dp0tmp\%button%%app%" -o readyapps\
ren readyapps\%id%_0.0.8_all.ipk "%button% %app%.ipk" 2>nul
cls
echo %button% %app%.ipk generated
rd /q /s "%~dp0tmp" 2>nul
echo.
if "%promptinstall%"=="yes" (
echo press I to install %button% %app%.ipk or any other key for exit
set /p "install=your choice: "
if "!install!" == "i" (
call install.cmd "%button% %app%.ipk"
)) else pause