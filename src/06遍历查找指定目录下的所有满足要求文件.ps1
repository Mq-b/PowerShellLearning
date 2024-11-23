$searchPath = "..\File\06test"
$outputFileName = "..\OutPut\06test1.txt"
$outputChineseStrings = "..\OutPut\06test2.txt"
$filter = "*.txt"
$RegexString = '\".*?[\p{IsCJKUnifiedIdeographs}].*?\"'

function Clear-FileIfNotEmpty { 
    param ([string]$filePath) 
    if ((Test-Path -Path $filePath) -and ((Get-Item -Path $filePath).Length -gt 0)) { 
        Clear-Content -Path $filePath 
        Write-Debug "已清空文件: $filePath"
    } 
}

# 判断文件是否存在且有内容 如果是就清除
Clear-FileIfNotEmpty -filePath $outputFileName
Clear-FileIfNotEmpty -filePath $outputChineseStrings

$filePaths = Get-ChildItem -Path $searchPath -Recurse -Filter $filter

# 其实相当于给 $filePaths 这个对象数组（即满足要求的文件） 遍历一遍，执行我们花括号中的脚本块
$filePaths | ForEach-Object {
    $filePath = $_.FullName # $_ 表示当前

    # 将满足 -Filter 要求的文件路径写入到文件中
    Add-Content -Path $outputFileName -Value $filePath

    # 读取文件内容
    $fileContent = Get-Content -Path $filePath -Raw

    # 正则匹配双引号中文字符串
    $matche = [regex]::Matches($fileContent, $RegexString)

    if($matche.Count -gt 0){
        # 将文件名写入输出文件
        Add-Content -Path $outputChineseStrings -Value "文件名: $filePath"
        foreach ($match in $matche) {
            # 将匹配的字符串写入输出文件
            Add-Content -Path $outputChineseStrings -Value $match.Value
        }

        # 添加空行分隔不同文件
        Add-Content -Path $outputChineseStrings -Value ""
    }
}
