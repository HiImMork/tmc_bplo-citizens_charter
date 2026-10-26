@echo off
rem Serves THIS folder at http://127.0.0.1:8080 (this machine only).
rem If the server ever stops, it is restarted after 2 seconds.
cd /d "%~dp0"
:loop
python -m http.server 8080 --bind 127.0.0.1
timeout /t 2 /nobreak >nul
goto loop
