#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
完美剪贴板监控工具 v1.0
解决复制/剪切操作不确定是否成功的问题
特点：美观通知、置顶显示、3秒后渐变消失

作者：CodeBuddy
日期：2025-09-18
"""

import tkinter as tk
from tkinter import messagebox
import win32clipboard
import win32con
import time
import threading
import json
import os
from datetime import datetime


class ClipboardMonitor:
    def __init__(self):
        self.running = False
        self.last_clipboard = ""
        self.config = self.load_config()
        
        # 创建主窗口（隐藏）
        self.root = tk.Tk()
        self.root.withdraw()  # 隐藏主窗口
        
        print("🎯 完美剪贴板监控工具 v1.0")
        print("✨ 特点：美观通知、置顶显示、渐变消失")
        print("🔄 正在监控剪贴板变化...")
        print("⏹️  按 Ctrl+C 退出程序")
        print("-" * 50)
        
    def load_config(self):
        """加载配置文件"""
        default_config = {
            "show_notification": True,
            "notification_duration": 3000,
            "preview_length": 50,
            "log_enabled": True,
            "sound_enabled": False,
            "window_width": 350,
            "window_height": 120,
            "fade_steps": 10,
            "fade_delay": 0.1
        }
        
        try:
            if os.path.exists("config.json"):
                with open("config.json", "r", encoding="utf-8") as f:
                    config = json.load(f)
                    return {**default_config, **config}
        except Exception as e:
            print(f"⚠️  配置文件加载失败，使用默认配置: {e}")
        return default_config
    
    def get_clipboard_content(self):
        """获取剪贴板内容"""
        try:
            win32clipboard.OpenClipboard()
            try:
                data = win32clipboard.GetClipboardData(win32con.CF_UNICODETEXT)
                return data
            except:
                return ""
        except:
            return ""
        finally:
            try:
                win32clipboard.CloseClipboard()
            except:
                pass
    
    def show_notification(self, content):
        """显示美观的通知窗口"""
        if not self.config["show_notification"]:
            return
            
        # 创建通知窗口
        notification = tk.Toplevel(self.root)
        notification.title("复制成功")
        
        # 窗口设置
        width = self.config["window_width"]
        height = self.config["window_height"]
        notification.geometry(f"{width}x{height}")
        notification.configure(bg="#2d3748")
        notification.overrideredirect(True)  # 无边框
        notification.attributes("-topmost", True)  # 置顶
        notification.attributes("-alpha", 0.95)  # 半透明
        
        # 获取屏幕尺寸并定位到右下角
        screen_width = notification.winfo_screenwidth()
        screen_height = notification.winfo_screenheight()
        x = screen_width - width - 20
        y = screen_height - height - 50
        notification.geometry(f"{width}x{height}+{x}+{y}")
        
        # 创建内容框架
        frame = tk.Frame(notification, bg="#2d3748", padx=20, pady=15)
        frame.pack(fill="both", expand=True)
        
        # 成功图标和标题
        title_frame = tk.Frame(frame, bg="#2d3748")
        title_frame.pack(fill="x", pady=(0, 10))
        
        icon_label = tk.Label(title_frame, text="✓", font=("Arial", 20, "bold"), 
                             fg="#48bb78", bg="#2d3748")
        icon_label.pack(side="left")
        
        title_label = tk.Label(title_frame, text="复制成功！", font=("微软雅黑", 12, "bold"), 
                              fg="#ffffff", bg="#2d3748")
        title_label.pack(side="left", padx=(10, 0))
        
        # 内容预览
        preview = content[:self.config["preview_length"]]
        if len(content) > self.config["preview_length"]:
            preview += "..."
            
        content_label = tk.Label(frame, text=preview, font=("微软雅黑", 9), 
                                fg="#a0aec0", bg="#2d3748", wraplength=300, justify="left")
        content_label.pack(fill="x")
        
        # 点击关闭功能
        def close_notification(event=None):
            try:
                notification.destroy()
            except:
                pass
        
        # 绑定点击事件到所有组件
        for widget in [notification, frame, title_frame, icon_label, title_label, content_label]:
            widget.bind("<Button-1>", close_notification)
        
        # 渐变消失效果
        def fade_out():
            try:
                steps = int(self.config["fade_steps"])
                delay = float(self.config["fade_delay"])
                for i in range(steps):
                    alpha = 0.95 * (steps - i - 1) / steps
                    notification.attributes("-alpha", alpha)
                    time.sleep(delay)
                notification.destroy()
            except:
                pass
        
        # 3秒后开始渐变消失
        threading.Timer(3.0, fade_out).start()
        
    def log_clipboard_change(self, content):
        """记录剪贴板变化"""
        if not self.config["log_enabled"]:
            return
            
        try:
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            preview = content[:100].replace('\n', ' ').replace('\r', ' ')
            
            log_entry = f"[{timestamp}] 复制: {preview}\n"
            
            with open("clipboard_log.txt", "a", encoding="utf-8") as f:
                f.write(log_entry)
        except Exception as e:
            print(f"⚠️  日志记录失败: {e}")
    
    def monitor_clipboard(self):
        """监控剪贴板变化"""
        self.last_clipboard = self.get_clipboard_content()
        
        while self.running:
            try:
                current_clipboard = self.get_clipboard_content()
                
                if current_clipboard and current_clipboard != self.last_clipboard:
                    print(f"📋 检测到复制操作: {current_clipboard[:50]}...")
                    
                    # 显示通知
                    self.root.after(0, lambda: self.show_notification(current_clipboard))
                    
                    # 记录日志
                    self.log_clipboard_change(current_clipboard)
                    
                    self.last_clipboard = current_clipboard
                
                time.sleep(0.5)  # 每0.5秒检查一次
                
            except Exception as e:
                print(f"❌ 监控出错: {e}")
                time.sleep(1)
    
    def start(self):
        """启动监控"""
        self.running = True
        
        # 在后台线程中监控剪贴板
        monitor_thread = threading.Thread(target=self.monitor_clipboard, daemon=True)
        monitor_thread.start()
        
        try:
            # 运行主循环
            self.root.mainloop()
        except KeyboardInterrupt:
            print("\n👋 程序已退出")
            self.running = False


def main():
    try:
        monitor = ClipboardMonitor()
        monitor.start()
    except KeyboardInterrupt:
        print("\n👋 程序已退出")
    except Exception as e:
        print(f"❌ 程序启动失败: {e}")
        input("按回车键退出...")


if __name__ == "__main__":
    main()