param ([switch]$Debug) 
if ($Debug) { 
    $DebugPreference = 'Continue' 
} else {
    $DebugPreference = 'SilentlyContinue'
}

# 获取系统时间 函数可以没有返回类型与 return (函数的最后一个表达式的结果也会被返回)
function Get-SystemTime{
    [System.DateTime]::Now.ToString("HH:mm:ss")
}

# 接受参数的函数
function Convert-ToUpperCase{
    param(
        [string]$text
    )
    return [regex]::Replace($text, "[a-z]", { param ($match) $match.Value.ToUpper() }) 
}

# 检查文件路径是否存在并且有内容，如果文件路径存在且文件有内容就清除
function Clear-FileIfNotEmpty { 
    param ([string]$filePath) 
    if ((Test-Path -Path $filePath) -and ((Get-Item -Path $filePath).Length -gt 0)) { 
        Clear-Content -Path $filePath 
        Write-Debug "已清空文件: $filePath"
    } 
}

$Result = Get-SystemTime                     # 调用函数简单函数
Write-Host "Get-SystemTime: $Result";

$text = "abcde"
$Result = Convert-ToUpperCase -text "$text"   # 调用简单函数传递参数
Write-Host "函数: $Result"

$filePath = "..\File\05test.txt"
$outputPath = "..\OutPut\05output.txt"
$fileContent = Get-Content -Path $filePath    # 调用函数读取文件 一次性读取
Write-Debug "$filePath 内容: $fileContent"

Clear-FileIfNotEmpty -filePath $outputPath    # 先清空要写入的文件

Get-Content -Path $filePath | ForEach-Object{ # 逐行读取处理
    $line = Convert-ToUpperCase -text $_ # 获取当前行的内容并传递给函数
    Write-Debug "Processing line: $line"
    Add-Content -Path $outputPath -Value $line # 处理完毕后写入文件 (追加)
}
