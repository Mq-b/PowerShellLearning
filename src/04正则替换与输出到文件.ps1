$text = Read-Host "请输入测试字符串"

# 简单替换
$updateText = $text -replace "a","A"
Write-Host "a 替换 A: $updateText"

# 正则表达式进行替换将小写字母全部替换为大写 最后一段类似于 lambda 表达式，为每一个匹配项调用它转为大写
$updateText = [regex]::Replace($text, "[a-z]", { param ($match) $match.Value.ToUpper() }) 
Write-Host "[a-z] 替换为 [A-Z]: $updateText"

# 保存结果到文件
$OutputPath = "..\OutPut\output.txt"
$updateText | Out-File -FilePath $OutputPath -Encoding utf8 # 一次性写入，如果有内容会先清空文件
Write-Host "替换结果已经保存到: $outputPath"
