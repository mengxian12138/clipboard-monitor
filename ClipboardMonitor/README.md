# 🎯 Windows 剪贴板监控工具

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.7+](https://img.shields.io/badge/python-3.7+-blue.svg)](https://www.python.org/downloads/)
[![Windows](https://img.shields.io/badge/platform-Windows-blue.svg)](https://www.microsoft.com/windows/)

一个美观实用的 Windows 剪贴板监控工具，当你复制文本时会在右下角显示优雅的通知窗口，解决复制操作不确定是否成功的问题。

## ✨ 功能特点

- 🎨 **美观界面** - 深色主题，现代化设计
- 🔝 **置顶显示** - 通知窗口始终在最前面，不会被遮挡
- ⏰ **渐变消失** - 3秒后优雅的淡出动画效果
- 👆 **点击关闭** - 可以点击通知窗口立即关闭
- 📝 **历史记录** - 自动记录所有复制操作到日志文件
- 🔧 **高度可配置** - 通过 config.json 自定义各种设置
- 🚀 **一键运行** - 自动检测并安装所需环境

## 🚀 快速开始

### 方法一：一键安装运行（推荐）
```bash
# 双击运行，自动安装所有依赖
一键安装运行.bat
```

### 方法二：手动运行
```bash
# 1. 安装依赖
pip install -r requirements.txt

# 2. 运行程序
python clipboard_monitor.py
```

## 📱 使用效果

当你复制文本时会看到：
- 📱 右下角出现美观的深色通知窗口
- ✅ 绿色 "✓" 图标 + "复制成功！" 标题  
- 📝 显示复制内容的前50个字符预览
- ⏰ 3秒后开始渐变淡出
- 👆 可以点击通知立即关闭

## 🔧 配置说明

编辑 `config.json` 文件可以自定义：

```json
{
  "show_notification": true,      // 是否显示通知
  "notification_duration": 3000,  // 通知显示时长（毫秒）
  "preview_length": 50,          // 预览文本长度
  "log_enabled": true,           // 是否启用日志记录
  "window_width": 350,           // 通知窗口宽度
  "window_height": 120,          // 通知窗口高度
  "fade_steps": 10,              // 渐变步数
  "fade_delay": 0.1              // 渐变延迟（秒）
}
```

## 📁 项目结构

```
ClipboardMonitor/
├── clipboard_monitor.py    # 主程序文件
├── config.json            # 配置文件
├── requirements.txt       # Python依赖
├── 一键安装运行.bat        # 一键安装启动脚本
├── 启动监控.bat           # 启动脚本
├── scripts/               # 管理工具脚本
│   ├── 安装依赖.bat
│   ├── 后台启动.bat
│   ├── 停止监控.bat
│   ├── 设置开机启动.bat
│   └── 系统兼容性检查.bat
└── docs/                  # 文档文件
```

## 📋 系统要求

- **操作系统**: Windows 7/8/10/11 (32位/64位)
- **Python**: 3.7+ (程序可自动安装)
- **依赖**: pywin32 (程序可自动安装)
- **内存**: 至少512MB可用内存
- **磁盘**: 至少100MB可用空间

## 🛠️ 管理工具

| 脚本文件 | 功能说明 |
|---------|---------|
| `一键安装运行.bat` | 自动检测环境并安装依赖，然后启动程序 |
| `启动监控.bat` | 启动程序（显示详细信息） |
| `scripts/后台启动.bat` | 后台静默启动 |
| `scripts/停止监控.bat` | 停止所有监控程序 |
| `scripts/设置开机启动.bat` | 设置开机自动启动 |
| `scripts/系统兼容性检查.bat` | 检查系统环境和诊断问题 |

## 🔧 故障排除

### 常见问题

**Q: 提示未找到Python**
- A: 运行 `scripts/install_python.bat` 自动安装，或手动访问 [Python官网](https://www.python.org/downloads/) 下载安装

**Q: 通知不显示**
- A: 检查 `config.json` 中 `show_notification` 是否为 `true`，运行 `scripts/安装依赖.bat` 确保依赖已安装

**Q: 程序无法启动**
- A: 运行 `scripts/停止监控.bat` 停止可能冲突的程序，然后重新运行 `启动监控.bat`

## 📊 日志功能

程序会自动在 `clipboard_log.txt` 中记录：
- 复制时间戳
- 复制内容预览（前100个字符）
- 方便查看复制历史

## 🤝 贡献

欢迎贡献代码！请查看 [CONTRIBUTING.md](CONTRIBUTING.md) 了解如何参与项目。

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🌟 Star History

如果这个项目对你有帮助，请给它一个 ⭐️！

## 📞 联系方式

- 🐛 Issues: [GitHub Issues](../../issues)
- 💬 Discussions: [GitHub Discussions](../../discussions)

---

**享受无忧的复制体验！** 🎉