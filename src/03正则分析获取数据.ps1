$text = Read-Host "请输入需要处理的字符串"

$chineseCharPattern = '[\p{IsCJKUnifiedIdeographs}]+' # 匹配所有中文字符
$parenthesesContentPattern = '\(([^)]+)\)'            # 匹配所有 () 之间的内容
$count = 1;

if($text -match "fox"){
    Write-Host "匹配到 fox" -ForegroundColor Blue
}elseif($text -match $chineseCharPattern){
    Write-Host "匹配到中文" -ForegroundColor Green
    # 使用正则表达式获取所有中文字符串
    $ChineseString = [regex]::Matches($text,$chineseCharPattern)
    foreach($matche in $ChineseString){
        Write-Host "匹配到的中文字符串 [$count]: $matche" -ForegroundColor Yellow
        $count++
    }
}

$parenthesesMatches = [regex]::Matches($text, $parenthesesContentPattern)
if($parenthesesMatches.Count -gt 0){
    Write-Host "匹配到的括号中内容: "
    $count = 1
    foreach($match in $parenthesesMatches){
        Write-Host "[$count]: $match" -ForegroundColor Blue
        $count++
    }
}else{
    Write-Host "没有匹配到 () 的内容" -ForegroundColor Red
}

# 输入字符串测试：
# 乐呵abc(abc)I(笑死)乐(bb)
# 乐呵abc
