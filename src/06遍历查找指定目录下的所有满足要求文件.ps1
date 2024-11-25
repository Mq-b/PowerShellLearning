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

# 获取指定目录中的项（powershell 中 ls 就是它的别名），-Recurse 递归查找所有子目录的内容，用于查找文件。
$filePaths = Get-ChildItem -Path $searchPath -Recurse -Filter $filter

# 给 $filePaths 这个对象数组（即满足要求的文件）遍历一遍，每个文件都执行我们花括号中的脚本块
$filePaths | ForEach-Object {
    $filePath = $_.FullName # $_ 表示当前

    # 将满足 -Filter 要求的文件路径写入到文件中
    Add-Content -Path $outputFileName -Value $filePath

    # 读取文件内容（确保文件存在内容才读取）
    if ((Test-Path -Path $filePath) -and ((Get-Item -Path $filePath).Length -gt 0)) {
        $fileContent = Get-Content -Path $filePath -Raw -Encoding UTF8 # 读取文件内容（使用 UTF8 因为我们的文件是，确保多环境都正常运行）
    } else {
        Write-Warning "文件为空或无法读取: $filePath"
        return # 跳出当前代码块 处理下下一个对象
    }

    # 正则匹配双引号中文字符串
    $matche = [regex]::Matches($fileContent, $RegexString)

    if($matche.Count -gt 0){
        # 将文件名写入输出文件
        Add-Content -Path $outputChineseStrings -Value "FileName: $filePath"
        foreach ($match in $matche) {
            # 将匹配的字符串写入输出文件
            Add-Content -Path $outputChineseStrings -Value $match.Value 
        }

        # 添加空行分隔不同文件
        Add-Content -Path $outputChineseStrings -Value ""
    }
}
# 写入文件的编码取决于当前区域，读取因为是我们提供的文件，一定是 utf-8 所以我们添加 -Encoding UTF8
# 普通 windows 用户无需太纠结 utf-8，不然乱码是常态
