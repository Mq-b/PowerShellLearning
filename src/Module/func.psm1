function Clear-FileIfNotEmpty { 
    param ([string]$filePath) 
    if ((Test-Path -Path $filePath) -and ((Get-Item -Path $filePath).Length -gt 0)) { 
        Clear-Content -Path $filePath 
        Write-Debug "已清空文件: $filePath"
    } 
}
function Get-SystemTime{
    [System.DateTime]::Now.ToString("HH:mm:ss")
}

Export-ModuleMember -Function Clear-FileIfNotEmpty, Get-SystemTime
