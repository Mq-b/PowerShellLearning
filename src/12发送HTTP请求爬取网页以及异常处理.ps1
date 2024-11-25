Import-Module -Name ./Module/func.psm1

# 设置目标URL
$url = "https://zh.cppreference.com/w/cpp/comment"
$filePath = "..\OutPut\12test.html"

Clear-FileIfNotEmpty -filePath $filePath

try {
    # 发送 HTTP GET 请求并获取响应
    $response = Invoke-WebRequest -Uri $url -Method Get

    # 将内容写入到文件
    $htmlContent = $response.Content
    Add-Content -Path $filePath -Value $htmlContent
    # throw [System.ArgumentException]::new("HTTP GET ERROR!", "HTTP GET");
}
catch {
    Write-Warning "Exception $_";
}
