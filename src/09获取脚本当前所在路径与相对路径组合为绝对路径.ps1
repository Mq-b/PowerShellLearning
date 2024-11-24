# 获取当前脚本所在的目录
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# 相对路径
$relativePath = "..\OutPut\08test.txt"
# 组合绝对路径和相对路径
$combinedPath = Join-Path -Path $scriptDir -ChildPath $relativePath
# 获取绝对路径 
$outputPath = (Resolve-Path -Path $combinedPath).Path
# 输出绝对路径
Write-Host "输出文件路径: $outputPath"
