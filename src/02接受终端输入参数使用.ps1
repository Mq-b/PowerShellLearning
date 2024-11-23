param (
    [switch]$Debug  # 可接受一个开关参数 -Debug 用于控制 Write-Debug 是否输出
)

if ($Debug) {
    $DebugPreference = 'Continue'
} else {
    $DebugPreference = 'SilentlyContinue'
}

# 定义对象接受输入
$Log = Read-Host "请输入日志信息"

$currentDate = Get-Date
Write-Debug "当前日志: $Log"
Write-Host "当前日期（始终显示）: $currentDate" -ForegroundColor Green

# 根据用户输入的日志信息进行处理
if ($Log -eq "test") {
    Write-Host "$Log 分支" -ForegroundColor Yellow
} else {
    Write-Host "输入的日志信息是: $Log" -ForegroundColor Cyan
}
