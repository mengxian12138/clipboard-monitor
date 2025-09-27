@echo off
chcp 65001 >nul
echo 🚀 设置剪贴板监控工具开机自启动...
echo.

REM 获取当前目录
set CURRENT_DIR=%~dp0
set STARTUP_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

echo 📁 当前目录: %CURRENT_DIR%
echo 📁 启动目录: %STARTUP_DIR%
echo.

REM 创建启动快捷方式
echo 📝 正在创建启动快捷方式...
copy "%CURRENT_DIR%后台启动.bat" "%STARTUP_DIR%\剪贴板监控工具.bat"

if %errorlevel% equ 0 (
    echo ✅ 开机自启动设置成功！
    echo 💡 程序将在下次开机时自动启动
    echo 📍 快捷方式位置: %STARTUP_DIR%\剪贴板监控工具.bat
) else (
    echo ❌ 设置失败，请检查权限
    echo 💡 可以手动将"后台启动.bat"复制到启动文件夹
)

echo.
echo 🗑️  如需取消开机启动，请删除启动文件夹中的快捷方式
echo.
pause