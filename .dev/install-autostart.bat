@echo off
rem ONE-TIME SETUP. Log in as the kiosk user, then right-click this file > "Run as administrator".
net session >nul 2>&1 || (echo Please run this file as Administrator. & pause & exit /b 1)

rem Never sleep, hibernate, or turn the screen off while plugged in
powercfg /change standby-timeout-ac 0
powercfg /change hibernate-timeout-ac 0
powercfg /change monitor-timeout-ac 0

rem Run start-kiosk.bat 10 seconds after this user logs in
schtasks /create /tn "KioskStart" /tr "\"%~dp0start-kiosk.bat\"" /sc onlogon /delay 0000:10 /rl limited /f

echo.
echo Done. To remove the auto-start later:  schtasks /delete /tn "KioskStart" /f
pause
