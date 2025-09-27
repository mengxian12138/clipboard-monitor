@echo off
chcp 65001 >nul
title 系统兼容性检查
color 0E

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🔍 系统兼容性检查                         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

echo 📋 系统信息：
echo ----------------------------------------
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type"
echo.

echo 🔍 Python环境检查：
echo ----------------------------------------

REM 检查各种Python安装
set FOUND_COUNT=0

echo 正在搜索Python安装...

REM 用户目录Python
if exist "C:\Users\%USERNAME%\AppData\Local\Programs\Python\" (
    echo ✅ 找到用户Python安装目录
    dir "C:\Users\%USERNAME%\AppData\Local\Programs\Python\" /B | findstr "Python"
    set /a FOUND_COUNT+=1
)

REM 系统Python
if exist "C:\Program Files\Python*" (
    echo ✅ 找到系统Python安装 ^(Program Files^)
    set /a FOUND_COUNT+=1
)

if exist "C:\Program Files (x86)\Python*" (
    echo ✅ 找到系统Python安装 ^(Program Files x86^)
    set /a FOUND_COUNT+=1
)

REM 根目录Python
if exist "C:\Python*" (
    echo ✅ 找到根目录Python安装
    set /a FOUND_COUNT+=1
)

REM 系统PATH中的Python
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Python在系统PATH中可用
    python --version
    set /a FOUND_COUNT+=1
)

py --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Python Launcher可用
    py --version
    set /a FOUND_COUNT+=1
)

echo.
echo 📊 检查结果：
echo ----------------------------------------
if %FOUND_COUNT% gtr 0 (
    echo ✅ 找到 %FOUND_COUNT% 个Python环境
    echo 💡 建议运行"便携版启动.bat"
) else (
    echo ❌ 未找到Python环境
    echo 💡 建议运行"一键安装运行.bat"
)

echo.
echo 🌐 网络连接检查：
echo ----------------------------------------
ping -n 1 www.python.org >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ 网络连接正常，可以下载Python
) else (
    echo ❌ 网络连接异常，可能影响Python下载
)

echo.
echo 🔧 管理员权限检查：
echo ----------------------------------------
net session >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ 当前具有管理员权限
) else (
    echo ⚠️  当前没有管理员权限
    echo 💡 某些安装操作可能需要管理员权限
)

echo.
echo 📁 磁盘空间检查：
echo ----------------------------------------
for /f "tokens=3" %%a in ('dir /-c ^| find "bytes free"') do set FREE_SPACE=%%a
echo 可用磁盘空间：%FREE_SPACE% 字节

echo.
echo ✅ 兼容性检查完成！
echo.
echo 💡 推荐操作：
if %FOUND_COUNT% gtr 0 (
    echo    1. 运行"便携版启动.bat" ^(推荐^)
    echo    2. 或运行"一键安装运行.bat" ^(重新安装^)
) else (
    echo    1. 运行"一键安装运行.bat" ^(推荐^)
    echo    2. 或手动安装Python后运行"便携版启动.bat"
)

echo.
pause