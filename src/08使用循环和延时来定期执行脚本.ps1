Import-Module -Name ./Module/func.psm1 -Force

$outputPath = "..\OutPut\08test.txt"
Clear-FileIfNotEmpty -filePath $outputPath

while($true){
    $currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "当前时间: $currentTime"
    Add-Content -Path $outputPath -Value $currentTime
    # 等待 10 秒
    Start-Sleep -Seconds 10
}
