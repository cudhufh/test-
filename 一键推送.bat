@echo off
chcp 65001 >nul
title 简历仓库一键推送
echo ========================================
echo    简历仓库一键推送到远程
echo ========================================
echo.
echo 正在启动 PowerShell 脚本...
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0一键推送.ps1"

if %errorlevel% neq 0 (
    echo.
    echo 脚本运行出错，按任意键退出...
    pause >nul
)
