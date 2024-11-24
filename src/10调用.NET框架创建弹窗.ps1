# 加载 Windows Forms 组件
Add-Type -AssemblyName System.Windows.Forms

# 创建一个消息弹窗
[System.Windows.Forms.MessageBox]::Show('这是一个弹窗消息!', '弹窗标题', 'OK', 'Information')

# 使用 WPF 自定义创建弹窗
Add-Type -AssemblyName PresentationFramework

# 创建一个窗口
$window = New-Object system.windows.window
$window.Title = "自定义弹窗"
$window.Width = 300
$window.Height = 200
$window.WindowStartupLocation = "CenterScreen"

# 创建一个网格布局
$grid = New-Object system.windows.controls.grid
$window.Content = $grid

# 创建一个文本块
$textBlock = New-Object system.windows.controls.textblock
$textBlock.Text = "这是一个自定义弹窗消息!"
$textBlock.HorizontalAlignment = "Center" # 水平居中 
$textBlock.Margin = "0,50,0,0"
$textBlock.FontSize = 20
$grid.Children.Add($textBlock) # 添加到布局中

# 创建一个按钮
$button = New-Object system.windows.controls.button
$button.Content = "关闭"
$button.HorizontalAlignment = "Center"
$button.VerticalAlignment = "Bottom"
$button.Margin = "0,0,0,20"
$button.FontSize = 20
$button.Width = 100
$button.Height = 40
$button.Add_Click({ # 设置点击事件
    Write-Host "关闭弹窗"
    $window.Close()
})
$grid.Children.Add($button) # 添加到布局中

# 显示窗口
$window.ShowDialog()
