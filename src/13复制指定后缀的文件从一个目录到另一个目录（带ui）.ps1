Add-Type -AssemblyName System.Windows.Forms

# 创建消息弹窗函数
function Show-MessageBox {
    param (
        [string]$Message,
        [string]$Title
    )
    
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show($Message, $Title, [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}

# 创建选择目录的函数
function Select-Folder {
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = "请选择一个目录"
    if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $folderBrowser.SelectedPath
    }
    return $null
}

# 创建输入框的函数
function Show-InputBox {
    param (
        [string]$Message,
        [string]$Title
    )
    
    Add-Type -AssemblyName Microsoft.VisualBasic
    return [Microsoft.VisualBasic.Interaction]::InputBox($Message, $Title, "")
}

# 弹出初始说明弹窗
Show-MessageBox -Message "此脚本用于将指定后缀的文件从一个目录复制到另一个目录。接下来请依次选择源目录和目标目录，并输入文件后缀。" -Title "文件复制工具"

# 弹出窗口选择源目录
$SourceDir = Select-Folder
if (-not $SourceDir) {
    Write-Host "未选择源目录，脚本终止。" -ForegroundColor Red
    exit
}

# 弹出窗口选择目标目录
$TargetDir = Select-Folder
if (-not $TargetDir) {
    Write-Host "未选择目标目录，脚本终止。" -ForegroundColor Red
    exit
}

# 弹出输入框输入文件后缀
$FileExtension = Show-InputBox -Message "请输入要复制的文件后缀（例如：.pdb）：" -Title "输入文件后缀"
if (-not $FileExtension) {
    Write-Host "未输入文件后缀，脚本终止。" -ForegroundColor Red
    exit
}

# 确保目标目录存在
if (-not (Test-Path -Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

# 获取指定后缀的文件并复制到目标目录
Get-ChildItem -Path $SourceDir -Recurse -Filter "*$FileExtension" | ForEach-Object {
    $TargetPath = Join-Path -Path $TargetDir -ChildPath $_.Name
    Copy-Item -Path $_.FullName -Destination $TargetPath -Force
}

Write-Host "所有 $FileExtension 文件已复制到 $TargetDir" -ForegroundColor Green
