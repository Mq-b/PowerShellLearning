# PowerShellLearning

<div style="text-align: center;">
    <img src="./image/PowerShell_5.0_icon.png" alt="PowerShell" width="150"/>
</div>

&emsp;&emsp;欢迎来到 **PowerShellLearning** 仓库！

&emsp;&emsp;这个仓库记录了我在学习和教学 PowerShell 脚本过程中的笔记、示例代码和实用脚本。

## 什么是 `PowerShell`?

PowerShell 是一个由微软开发的任务自动化和配置管理工具。**它既是一个命令行 Shell，也是一种脚本语言**。

- **命令行 Shell**：类似于 Windows 的 cmd（命令提示符），但功能更强大更现代。

- **脚本语言**：可以编写脚本来自动执行复杂任务，支持面向对象编程。

更多详细内容可参见微软 [PowerShell 文档](https://learn.microsoft.com/zh-cn/powershell/scripting/overview?view=powershell-7.4)。

另外 PowerShell 还定义了许多命令别名，使得我们命令行中的许多操作类似于 Unix/Linux shell。这让用户更容易上手，特别是那些习惯于 Unix/Linux 的用户。你可以通过命令 **`Get-Alias`** 查看对应关系。

### 常见别名示例

| 别名  | 对应 PowerShell 命令   | 说明                          |
|-------|-----------------------|-----------------------------|
| [`ls`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/get-childitem)  | `Get-ChildItem`       | 列出目录中的文件和文件夹     |
| [`dir`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/get-childitem) | `Get-ChildItem`       | 列出目录中的文件和文件夹     |
| [`cp`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/copy-item)  | `Copy-Item`           | 复制文件或文件夹             |
| [`mv`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/move-item)  | `Move-Item`           | 移动文件或文件夹             |
| [`rm`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/remove-item)  | `Remove-Item`         | 删除文件或文件夹             |
| [`cat`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/get-content) | `Get-Content`         | 显示文件内容                 |
| [`type`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/get-content) | `Get-Content`         | 显示文件内容                 |
| [`gc`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/get-content)  | `Get-Content`         | 显示文件内容                 |
| [`echo`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.utility/write-output)  | `Write-Output`        | 输出文本                     |
| [`cls`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.utility/clear-host)  | `Clear-Host`          | 清除控制台屏幕               |
| [`pwd`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/get-location)  | `Get-Location`        | 显示当前目录                 |
| [`cd`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/set-location)  | `Set-Location`        | 更改当前目录                 |
| [`sl`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/set-location)  | `Set-Location`        | 更改当前目录                 |
| [`mkdir`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/new-item)  | `New-Item`           | 创建新目录                   |
| [`rmdir`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/remove-item) | `Remove-Item`        | 删除目录                     |
| [`del`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.management/remove-item)  | `Remove-Item`         | 删除文件或文件夹             |

### 使用 `Get-Help` 获取 PowerShell 文档

在编写脚本时，我们经常需要查阅有关 PowerShell 命令和概念的详细信息。PowerShell 提供了强大的 [`Get-Help`](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/get-help?view=powershell-5.1&WT.mc_id=ps-gethelp) 命令，用于查询本地或在线文档。

#### 基本用法

`Get-Help` 的基本语法如下：

```powershell
Get-Help [[-Name] <String>]
```

例如，如果想了解 `Test-Path` 命令的作用和用法，可以使用以下命令：

```PowerShell
Get-Help Test-Path
```

#### 获取在线文档

通过添加 **`-Online`** 参数，`Get-Help` 可以直接打开命令的微软在线文档：

```PowerShell
Get-Help Test-Path -Online
```

## 环境

您无需拥有与我相同的环境，只需支持 PowerShell 即可（当然最好是开启了全局 `utf-8`）。以下是我的环境配置：

- **操作系统**

```PowerShell
(Get-WmiObject -Class Win32_OperatingSystem).Caption 
# 结果: Microsoft Windows 11 家庭中文版
```

- **区域设置**

```PowerShell
Get-WinSystemLocale
# 结果:
# LCID             Name             DisplayName
# ----             ----             -----------
# 2052             zh-CN             Chinese (Simplified, PRC)
```

- **字符集设置**

```Powershell
[System.Text.Encoding]::Default
# 结果:
# BodyName          : utf-8
# EncodingName      : Unicode (UTF-8)
# HeaderName        : utf-8
# WebName           : utf-8
# WindowsCodePage   : 1200
# IsBrowserDisplay  : True
# IsBrowserSave     : True
# IsMailNewsDisplay : True
# IsMailNewsSave    : True
# IsSingleByte      : False
# EncoderFallback   : System.Text.EncoderReplacementFallback
# DecoderFallback   : System.Text.DecoderReplacementFallback
# IsReadOnly        : True
# CodePage          : 65001
```

- **`PowerShell` 版本**

```PowerShell
$PSVersionTable.PSVersion
# 结果:
# Major  Minor  Build  Revision
# -----  -----  -----  --------
# 5      1      22621  4249
```

## 获取

```shell
git clone https://github.com/Mq-b/PowerShellLearning.git
```

## 仓库目录结构

- `src` 文件夹中存放着我们的 `.ps1` 脚本文件。

- `OutPut` 文件夹中通常是脚本进行文件写入操作存放输出文件的路径。

- `File` 文件夹通常是存放脚本进行读取的文件。

<!-- 还需思考 -->

## 贡献

欢迎你为这个仓库贡献内容！你可以提交Pull Request，分享你的学习笔记、脚本示例或改进建议。
具体步骤：

1. Fork 这个仓库。
2. 在你的分支上进行修改。
3. 提交 Pull Request，我们会尽快 review。

## 许可证

本仓库采用 [署名-非商业性使用 4.0 国际 (CC BY-NC 4.0)](https://creativecommons.org/licenses/by-nc/4.0/deed.zh-hans) 许可协议进行许可。
