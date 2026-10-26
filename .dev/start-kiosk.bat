@echo off
rem Starts the local server (if needed), waits for it, then opens Edge in kiosk mode.
setlocal
set "URL=http://127.0.0.1:8080/"
set "EDGE=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set "PROFILE=%~dp0edge-profile"

rem Close leftovers from a previous session
taskkill /im msedge.exe /f >nul 2>&1

rem Already serving? Skip starting it again.
curl.exe -s -o nul --max-time 2 %URL% && goto launch

start "KioskServer" /min "%~dp0run-server.bat"

rem Wait up to 30 seconds for the server to answer
set /a tries=0
:wait
curl.exe -s -o nul --max-time 2 %URL% && goto launch
set /a tries+=1
if %tries% GEQ 30 goto launch
timeout /t 1 /nobreak >nul
goto wait

:launch
start "" "%EDGE%" --kiosk "%URL%" --edge-kiosk-type=fullscreen --no-first-run --user-data-dir="%PROFILE%" --disk-cache-size=1 --disable-pinch --overscroll-history-navigation=0
