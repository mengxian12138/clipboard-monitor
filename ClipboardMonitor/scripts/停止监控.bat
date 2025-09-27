@echo off
chcp 65001 >nul
echo 🛑 正在停止剪贴板监控程序...

REM 结束Python进程
taskkill /f /im python.exe >nul 2>&1

REM 结束可能的其他监控进程
taskkill /f /im wscript.exe >nul 2>&1
taskkill /f /im cscript.exe >nul 2>&1

echo ✅ 监控程序已停止
echo.
pause