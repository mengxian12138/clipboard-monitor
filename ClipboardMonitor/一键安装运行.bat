@echo off
chcp 65001 >nul
title 剪贴板监控工具 - 一键安装运行
color 0A

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                🎯 剪贴板监控工具 - 一键安装运行              ║
echo ║                                                              ║
echo ║  本工具将自动检测并安装所需环境，无需手动配置！              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

echo 🔍 正在检测系统环境...
echo.

REM 检测操作系统
ver | find "Windows" >nul
if %errorlevel% neq 0 (
    echo ❌ 错误：本工具仅支持Windows系统
    pause
    exit /b 1
)
echo ✅ 操作系统：Windows

REM 检测Python环境
set PYTHON_FOUND=0
set PYTHON_PATH=

REM 方法1：检查用户安装的Python
if exist "C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312\python.exe" (
    set PYTHON_PATH=C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312\python.exe
    set PYTHON_FOUND=1
    echo ✅ 找到Python 3.12 ^(用户安装^)
    goto :check_deps
)

REM 方法2：检查系统Python
python --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_PATH=python
    set PYTHON_FOUND=1
    echo ✅ 找到系统Python
    goto :check_deps
)

REM 方法3：检查py launcher
py --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_PATH=py
    set PYTHON_FOUND=1
    echo ✅ 找到Python Launcher
    goto :check_deps
)

REM 未找到Python，开始安装
echo ❌ 未找到Python环境
echo.
echo 📥 正在自动安装Python 3.12...
echo    这可能需要几分钟时间，请耐心等待...
echo.

REM 检查winget是否可用
winget --version >nul 2>&1
if %errorlevel% equ 0 (
    echo 🔧 使用winget安装Python...
    winget install --id Python.Python.3.12 --exact --accept-source-agreements --accept-package-agreements --silent
    if %errorlevel% equ 0 (
        echo ✅ Python安装成功！
        set PYTHON_PATH=C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312\python.exe
        set PYTHON_FOUND=1
        goto :check_deps
    )
)

REM winget失败，尝试直接下载安装
echo 🔧 正在下载Python安装程序...
powershell -Command "try { Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe' -OutFile 'python-installer.exe' -UseBasicParsing } catch { exit 1 }"

if exist "python-installer.exe" (
    echo ✅ 下载完成，开始安装...
    start /wait python-installer.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0
    del python-installer.exe >nul 2>&1
    
    REM 刷新环境变量
    call :refresh_env
    
    REM 再次检查
    if exist "C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312\python.exe" (
        set PYTHON_PATH=C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312\python.exe
        set PYTHON_FOUND=1
        echo ✅ Python安装成功！
    ) else (
        echo ❌ Python安装失败
        echo 💡 请手动访问 https://www.python.org/downloads/ 下载安装
        pause
        exit /b 1
    )
) else (
    echo ❌ 下载失败，请检查网络连接
    echo 💡 请手动访问 https://www.python.org/downloads/ 下载安装
    pause
    exit /b 1
)

:check_deps
echo.
echo 🔍 正在检查Python依赖...

REM 检查pywin32
"%PYTHON_PATH%" -c "import win32clipboard" >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 缺少pywin32依赖
    echo 📦 正在安装pywin32...
    "%PYTHON_PATH%" -m pip install pywin32 --quiet
    if %errorlevel% equ 0 (
        echo ✅ pywin32安装成功
    ) else (
        echo ❌ pywin32安装失败
        echo 💡 请检查网络连接或手动安装
        pause
        exit /b 1
    )
) else (
    echo ✅ pywin32依赖已安装
)

echo.
echo 🚀 环境检查完成，启动程序...
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║  程序已启动！功能特点：                                      ║
echo ║  ✅ 美观的深色主题通知窗口                                   ║
echo ║  ✅ 自动置顶显示，不会被遮挡                                 ║
echo ║  ✅ 3秒后渐变淡出效果                                        ║
echo ║  ✅ 点击通知可立即关闭                                       ║
echo ║  ✅ 自动记录复制历史                                         ║
echo ║                                                              ║
echo ║  💡 现在试试复制一些文本，观察右下角的通知效果！              ║
echo ║  ⏹️  按Ctrl+C可退出程序                                      ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

"%PYTHON_PATH%" clipboard_monitor.py

echo.
echo 👋 程序已退出
pause
goto :eof

:refresh_env
REM 刷新环境变量的函数
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "UserPath=%%b"
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH 2^>nul') do set "SystemPath=%%b"
set "PATH=%UserPath%;%SystemPath%"
goto :eof