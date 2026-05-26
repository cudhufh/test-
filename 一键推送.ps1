# 一键推送脚本（PowerShell）
# 用法：右键 → 使用 PowerShell 运行，或双击运行

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   简历仓库一键推送到远程" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查是否在正确目录
Set-Location $PSScriptRoot

# 显示当前状态
Write-Host "【当前仓库状态】" -ForegroundColor Yellow
git status --short
if ($LASTEXITCODE -ne 0) {
    Write-Host "错误：当前目录不是 Git 仓库！" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "【现有远程仓库】" -ForegroundColor Yellow
git remote -v
Write-Host ""

# 询问用户远程地址
Write-Host "请输入你的远程仓库 SSH 地址（例如：git@gitee.com:clg/jianli.git）" -ForegroundColor Green
Write-Host "注意：" -ForegroundColor Red -NoNewline
Write-Host "请确保已在 Gitee/GitHub 添加了 SSH 公钥，且仓库为空仓库（未初始化）"
Write-Host ""
$remoteUrl = Read-Host "> 远程仓库地址"

if ([string]::IsNullOrWhiteSpace($remoteUrl)) {
    Write-Host "错误：地址不能为空！" -ForegroundColor Red
    pause
    exit 1
}

# 移除已有的 remote origin（如果存在）
git remote remove origin 2>$null

# 添加远程仓库
git remote add origin $remoteUrl
if ($LASTEXITCODE -ne 0) {
    Write-Host "错误：添加远程仓库失败！" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "【已配置远程仓库】" -ForegroundColor Yellow
git remote -v
Write-Host ""

# 推送
Write-Host "正在推送到远程仓库..." -ForegroundColor Green
git branch -M master
git push -u origin master

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "   ✅ 推送成功！" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "请访问你的 Gitee/GitHub 仓库查看文件。" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "   ❌ 推送失败" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "常见原因：" -ForegroundColor Yellow
    Write-Host "1. SSH 公钥未添加到平台"
    Write-Host "2. 远程仓库地址错误"
    Write-Host "3. 远程仓库不是空仓库（已初始化 README/.gitignore）"
    Write-Host ""
    Write-Host "解决方法：参考 推送指南.md" -ForegroundColor Cyan
}

Write-Host ""
pause
