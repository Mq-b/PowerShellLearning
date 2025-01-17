#!/usr/bin/env pwsh

# 获取当前仓库的 Git 哈希值
$git_hash = git rev-parse HEAD 2>$null

# 获取当前仓库的 Git 版本标签
$git_tag = git describe --tags --always 2>$null

# 获取当前的 Git 分支名
$git_branch = git branch --show-current

# 获取当前仓库最新提交的时间
$git_commit_time = git log -1 --format=%cd --date=format:'%Y-%m-%d %H:%M:%S' 2>$null

# 获取构建的时间
$build_time = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

# 检查 Git 仓库状态
if (-not $git_hash -or -not $git_tag -or -not $git_commit_time) {
    Write-Error "Error: Not a valid Git repository or unable to retrieve Git information."
    exit 1
}

# 生成 version.h 文件
@"
#ifndef VERSION_H
#define VERSION_H

#include <string_view>

namespace version{
    constexpr std::string_view git_hash = "$git_hash";
    constexpr std::string_view git_tag = "$git_tag";
    constexpr std::string_view git_branch = "$git_branch";
    constexpr std::string_view git_commit_time = "$git_commit_time";
    constexpr std::string_view build_time = "$build_time";
};

#endif // VERSION_H
"@ | Out-File -Encoding utf8 version.h

# 提示生成成功
Write-Output "version.h 文件已生成:"
Get-Content version.h

# Linux 中：pwsh version.ps1 需要第一行。