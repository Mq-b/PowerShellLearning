# 引入模块

Import-Module -Name ./Module/func.psm1 -Force

$Result = Get-SystemTime                     # 调用函数简单函数
Write-Host "Get-SystemTime: $Result";
