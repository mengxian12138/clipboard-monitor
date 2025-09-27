@echo off
chcp 65001 >nul
echo 📦 正在安装Python依赖包...
echo.

set PYTHON_PATH=C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312\python.exe

if exist "%PYTHON_PATH%" (
    echo ✅ 找到Python 3.12
    echo 📥 正在安装pywin32...
    "%PYTHON_PATH%" -m pip install pywin32
    echo.
    echo ✅ 依赖安装完成！
) else (
    echo ❌ 未找到Python，请先安装Python
    echo 💡 可以运行 install_python.bat 自动安装
)

echo.
pause