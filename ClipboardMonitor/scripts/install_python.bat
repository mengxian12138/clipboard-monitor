@echo off
chcp 65001 >nul
echo 🐍 正在安装Python 3.12...
echo.

echo 📥 正在下载Python安装程序...
powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe' -OutFile 'python-installer.exe'"

if exist "python-installer.exe" (
    echo ✅ 下载完成，开始安装...
    echo 📝 安装选项：添加到PATH，为所有用户安装
    python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    
    echo ⏳ 等待安装完成...
    timeout /t 30 /nobreak >nul
    
    echo 🧹 清理安装文件...
    del python-installer.exe
    
    echo ✅ Python安装完成！
    echo 💡 请重新启动命令提示符或重启电脑以使PATH生效
) else (
    echo ❌ 下载失败，请检查网络连接
    echo 💡 或手动访问 https://www.python.org/downloads/ 下载安装
)

echo.
pause