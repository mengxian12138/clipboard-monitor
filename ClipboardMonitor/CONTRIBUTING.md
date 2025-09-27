# 贡献指南

感谢您对剪贴板监控工具项目的关注！我们欢迎各种形式的贡献。

## 🤝 如何贡献

### 报告问题
- 使用 [GitHub Issues](../../issues) 报告 bug
- 提供详细的问题描述和复现步骤
- 包含系统信息（Windows版本、Python版本等）

### 提出功能建议
- 使用 [GitHub Issues](../../issues) 提出新功能建议
- 详细描述功能需求和使用场景
- 说明该功能的价值和必要性

### 提交代码
1. Fork 本仓库
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📝 代码规范

### Python 代码风格
- 遵循 PEP 8 规范
- 使用有意义的变量和函数名
- 添加适当的注释和文档字符串
- 保持代码简洁易读

### 提交信息规范
- 使用清晰简洁的提交信息
- 格式：`类型: 简短描述`
- 类型包括：feat（新功能）、fix（修复）、docs（文档）、style（格式）、refactor（重构）、test（测试）

### 示例
```
feat: 添加声音提示功能
fix: 修复通知窗口在多显示器下的位置问题
docs: 更新安装说明
```

## 🧪 测试

在提交代码前，请确保：
- 代码能在 Windows 7/8/10/11 上正常运行
- 测试了主要功能（复制监控、通知显示、配置加载）
- 没有引入新的依赖（除非必要）

## 📋 开发环境设置

1. 克隆仓库
```bash
git clone https://github.com/yourusername/clipboard-monitor.git
cd clipboard-monitor
```

2. 安装依赖
```bash
pip install -r requirements.txt
```

3. 运行程序
```bash
python clipboard_monitor.py
```

## 🎯 开发重点

当前项目重点关注：
- 性能优化
- 用户体验改进
- 跨Windows版本兼容性
- 错误处理完善

## 📞 联系方式

如有疑问，请通过以下方式联系：
- GitHub Issues
- GitHub Discussions

感谢您的贡献！🎉