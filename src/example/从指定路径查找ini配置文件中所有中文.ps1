$searchPath = "searchPath"
$outputChineseStrings = "outputChineseStrings"
$outputFileName = "outputFileName"
$MatchedStrings = "*.ini"
$RegexString = '=.*[\p{IsCJKUnifiedIdeographs}].*'  # 需要匹配 = 开头且含有中文的行

function Clear-FileIfNotEmpty { 
    param ([string]$filePath) 
    if ((Test-Path -Path $filePath) -and ((Get-Item -Path $filePath).Length -gt 0)) { 
        Clear-Content -Path $filePath 
        Write-Debug "已清空文件: $filePath"
    } 
}

Clear-FileIfNotEmpty -filePath $outputFileName
Clear-FileIfNotEmpty -filePath $outputChineseStrings

$filePaths = Get-ChildItem -Path $searchPath -Recurse -Filter $MatchedStrings

# 使用HashSet避免重复
$existingValues = New-Object System.Collections.Generic.HashSet[string]

$filePaths | ForEach-Object {
    $filePath = $_.FullName

    if ((Test-Path -Path $filePath) -and ((Get-Item -Path $filePath).Length -gt 0)) {
        $fileContent = Get-Content -Path $filePath -Raw
    } else {
        Write-Warning "文件为空或无法读取: $filePath"
        return
    }

    $matche = [regex]::Matches($fileContent, $RegexString)

    if ($matche.Count -gt 0) {
        Add-Content -Path $outputFileName -Value $filePath
        Write-Host "File: $filePath"
        Add-Content -Path $outputChineseStrings -Value "文件名: $filePath"

        foreach ($match in $matche) {
            # 获取每个匹配项的值，并去除前面的 '=' 字符
            $value = $match.Value.TrimStart('=')

            # 确保不重复（value 不为空且哈希 set 不包含 valuie）
            if ($value -and -not $existingValues.Contains($value)) {
                Add-Content -Path $outputChineseStrings -Value $value -NoNewline # 避免每次写入的换行
                $existingValues.Add($value)
            }
        }
    }
}
