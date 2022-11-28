@echo off
set tv=oled
setlocal EnableExtensions enabledelayedexpansion
set app=%1
if defined app set app=%app:"=%
if defined app goto :doit
:m1
cls
set n=0
for /r %%a in (readyapps\*) do (
  set /a n+=1
  set "menu_!n!=%%~nxa"
  echo press !n! for %%~nxa
)
echo press 0 for exit
set /p "take=your choice: "
if "!take!"=="0" echo bb. cya. && goto :eof
set app=!menu_%take%!
if not defined app goto m1
:doit
call ..\ares-install.cmd "%~dp0readyapps\%app%" -d %tv% 
pause