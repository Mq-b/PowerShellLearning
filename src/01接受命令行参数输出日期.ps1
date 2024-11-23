param (
    [switch]$Debug,  # 接受一个开关参数 -Debug
    [string]$Log     # 接受一个字符串
)

if ($Debug) {
    $DebugPreference = 'Continue'
} else {
    $DebugPreference = 'SilentlyContinue'
}

$currentDate = Get-Date
Write-Debug "Current Log $Log"
Write-Host "Current date (always shown): $currentDate" -ForegroundColor Green

<#
使用：
.\01接受命令行参数输出日期.ps1 -Debug -Log "test"
.\01接受命令行参数输出日期.ps1 -Debug "test"
.\01接受命令行参数输出日期.ps1 -Debug -Log $env:PATH
#>
