@echo off
chcp 65001 >nul
title 剪贴板监控工具
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🎯 剪贴板监控工具 v1.0                    ║
echo ╠══════════════════════════════════════════════════════════════╣
echo ║  功能特点：                                                  ║
echo ║  ✅ 美观的深色主题通知窗口                                   ║
echo ║  ✅ 自动置顶显示，不会被遮挡                                 ║
echo ║  ✅ 3秒后渐变淡出效果                                        ║
echo ║  ✅ 点击通知可立即关闭                                       ║
echo ║  ✅ 自动记录复制历史到日志文件                               ║
echo ║  ✅ 可通过config.json自定义配置                              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM 检查Python环境
set PYTHON_PATH=C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312\python.exe

if exist "%PYTHON_PATH%" (
    echo ✅ 找到Python 3.12，启动监控程序...
    echo 🚀 程序启动中，请稍候...
    echo.
    "%PYTHON_PATH%" clipboard_monitor.py
) else (
    echo ❌ 未找到Python 3.12
    echo 💡 请确保已安装Python 3.12或更高版本
    echo 📥 下载地址：https://www.python.org/downloads/
    echo.
    echo 🔧 或者运行 install_python.bat 自动安装Python
)

echo.
echo 👋 程序已退出，按任意键关闭窗口...
pause >nul