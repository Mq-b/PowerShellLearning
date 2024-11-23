# PowerShellLearning

&emsp;&emsp;欢迎来到 **PowerShellLearning** 仓库！

&emsp;&emsp;这个仓库记录了我在学习和教学 PowerShell 脚本过程中的笔记、示例代码和实用脚本。

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
