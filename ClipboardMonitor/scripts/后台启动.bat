@echo off
REM 静默启动剪贴板监控工具

set PYTHON_PATH=C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312\python.exe

if exist "%PYTHON_PATH%" (
    start /min "" "%PYTHON_PATH%" clipboard_monitor.py
) else (
    echo Python未安装，请先运行"启动监控.bat"查看详细信息
    pause
)