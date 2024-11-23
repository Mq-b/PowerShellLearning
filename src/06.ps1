# 设置查找路径 输出文件 查找文件
$searchPath = "F:\project\R3M\R3M\R3M"
$outputChineseStrings = "C:\Users\Administrator\Desktop\Output\ChineseStringsByFile.txt"
$outputFileName = "C:\Users\Administrator\Desktop\Output\FileName.txt"
$MatchedStrings = "*.xaml.cs"
$RegexString = '\".*?[\p{IsCJKUnifiedIdeographs}].*?\"'

Write-Host "查找路径：" + $searchPath
Write-Host "输出文件：" + $outputChineseStrings + " " + $outputFileName
Write-Host "匹配文件：" + $MatchedStrings

# 初始化输出文件 如果存在就清空 不存在则创建
$outputFiles = @($outputChineseStrings, $outputFileName)
foreach ($file in $outputFiles) {
    if (Test-Path $file) {
        Clear-Content -Path $file
    } else {
        New-Item -ItemType File -Path $file -Force | Out-Null
    }
}

# 查找所有满足 MatchedStrings 的文件
Get-ChildItem -Path $searchPath -Recurse -Filter $MatchedStrings | ForEach-Object {
    $filePath = $_.FullName
    $fileName = $_.Name

    # 将文件名写入输出文件
    Add-Content -Path $outputFileName -Value $fileName

    # 读取文件内容
    $fileContent = Get-Content -Path $filePath -Raw

    # 正则匹配双引号中文字符串
    $matche = [regex]::Matches($fileContent, $RegexString)

    if ($matche.Count -gt 0) { # 存在中文字符串 -gt 就是 >
        # 将文件名写入输出文件
        Add-Content -Path $outputChineseStrings -Value "文件名: $fileName"
        foreach ($match in $matche) {
            # 将匹配的字符串写入输出文件
            Add-Content -Path $outputChineseStrings -Value $match.Value
        }

        Add-Content -Path $outputChineseStrings -Value "-----------------------------------------------"

        # 添加空行分隔不同文件
        Add-Content -Path $outputChineseStrings -Value ""
    }
}

Write-Host "操作完成！"
