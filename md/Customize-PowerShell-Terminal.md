# 定制 `PowerShell` 终端

我们的定制并不是说一些美化、插件之类的东西，而是指另一种。

许多的开发环境、IDE 都会提供一些自己定制好的终端，里面有它的所有的工具链，我们只需要使用这个终端就行。

比如 `Visual Studio`、`Qt`、`MySql` 等等。

> `Visual Studio` 提供的终端里面存放着许多它需要用的的工具链，如：`Git`、`CMake`、`cl`、`nmake`、`msbuild`...

其实这并没有什么难度，无非是创建一个指向 `PowerShell.exe` 的快捷方式，同时添加一些命令，让其在启动前执行罢了。

## 自定义终端

先找到 PowerShell.exe 所在位置，然后右键创建快捷方式，我们选择发送到桌面。

右键这个快捷方式的属性：

```PowerShell
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
```

它只是单纯的启动，我们可以给它添加 **`-Command` 选项**，**指定要在启动时执行的命令**；以及添加 **`-NoExit` 选项防止自动退出**。

```PowerShell
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoExit -Command "echo 'Customize-PowerShell-Terminal'"
```

> 也可以使用环境变量拼接出 `powershell.exe` 的路径：
>
> ```PowerShell
> %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
> ```
>
> `%SystemRoot%`：这是一个环境变量，通常表示 Windows 安装目录，**可以确保脚本在不同系统上运行时，不需要修改路径**。
> 我们可以 `echo $env:SystemRoot` 来输出环境变量的值。

如果想要执行多条命令，就需要使用 `&{}` 包裹，并用 `;` 分隔：

```PowerShell
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoExit -Command "&{echo '伟大无需多言'; $Mq_b='伟大无需多言'; Write-Host $Mq_b}"
```

当然了，最简单的还是直接编写一个脚本让其执行：

```PowerShell
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoExit -Command "C:\Users\Administrator\Desktop\test.ps1"
```

`test.ps1`：

```PowerShell
$global:currentTime = (Get-Date).ToString("HH:MM:ss")
Write-Host $currentTime -ForegroundColor Red
```

- **声明全局变量确保在脚本执行完之后依然可以使用，直到这个 PowerShell 回话结束才会被释放**。

打开终端执行命令：

```PowerShell
13:11:34
PS C:\Windows\System32\WindowsPowerShell\v1.0> echo $currentTime
13:11:34
PS C:\Windows\System32\WindowsPowerShell\v1.0>
```

## 将可执行程序添加到 PowerShell

其实我们都知道，可以直接设置环境变量，这样所有的终端都可以使用，但是我们想要的恰恰是“**定制**”

- 我只想让我这个终端能使用这个程序。

其实这种很正常，和一开始说的一样，许多开发环境都会提供定制好的终端。

我们可以修改上一节提供的脚本：

```PowerShell
$global:currentTime = (Get-Date).ToString("HH:MM:ss")
$global:CMake = "D:\CMake\bin"
# 临时将 CMake 的路径添加到 PATH 环境变量
$env:PATH += ";$global:CMake"
Write-Host $currentTime -ForegroundColor Red
```

打开终端执行命令：

```PowerShell
10:11:16
PS C:\Windows\System32\WindowsPowerShell\v1.0> where.exe CMake
D:\CMake\bin\cmake.exe
PS C:\Windows\System32\WindowsPowerShell\v1.0> echo $CMake
D:\CMake\bin
PS C:\Windows\System32\WindowsPowerShell\v1.0> CMake --version
cmake version 3.30.0

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

其实你也可以只是**定义一个 CMake 变量**：

```PowerShell
$global:CMake = "D:\CMake\bin\cmake.exe"
```

但是使用会比较麻烦，你不能直接像 CMake 一样调用 `$CMake` 变量，因为 PowerShell 将其当作字符串，而不是命令。你需要使用 `&` 运算符来执行该路径。也就是：

```PowerShell
PS C:\Windows\System32\WindowsPowerShell\v1.0> & $CMake --version
cmake version 3.30.0

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

另外的做法是**定义一个 CMake 函数**：

```PowerShell
function Global:CMake{
    return &"D:\CMake\bin\cmake.exe"@args
}
```

- `&` 调用运算符。

- `Global:CMake` 定义全局函数，默认是局部的。在会话结束之后销毁。

- `@args` 是一个特殊的语法，用于将传递给函数的所有参数作为一个数组传递给 CMake 可执行文件。这意味着，任何传递给 CMake 函数的参数都会原封不动地传递给 `cmake.exe`。

使用起来和设置了环境变量没有区别，除了 `where.exe` 与 `Get-Command` 命令无法查找到 `cmake.exe` 的路径。

许多时候我们是不方便定义环境变量的[^1]，那个路径可能存在非常多的东西，我们就可以定义函数，以下是我的做法：

```PowerShell
$global:cl = "D:\visual studio 2022\VC\Tools\MSVC\14.41.34120\bin\Hostx64\x64\cl.exe"
$global:msbuild = "D:\visual studio 2022\MSBuild\Current\Bin\amd64\msbuild.exe"
$global:dumpbin = "D:\visual studio 2022\VC\Tools\MSVC\14.41.34120\bin\Hostx64\x64\dumpbin.exe"

function Global:cl{
    return & $cl @args
}

function Global:msbuild{
    return & $msbuild @args
}

function Global:dumpbin{
    return & $dumpbin @args
}
```

终端测试执行：

```bash
PS C:\Users\A1387\Desktop> echo $cl
D:\visual studio 2022\VC\Tools\MSVC\14.41.34120\bin\Hostx64\x64\cl.exe
PS C:\Users\A1387\Desktop> echo $msbuild
D:\visual studio 2022\MSBuild\Current\Bin\amd64\msbuild.exe
PS C:\Users\A1387\Desktop> echo $dumpbin
D:\visual studio 2022\VC\Tools\MSVC\14.41.34120\bin\Hostx64\x64\dumpbin.exe
PS C:\Users\A1387\Desktop> cl
用于 x64 的 Microsoft (R) C/C++ 优化编译器 19.41.34120 版
版权所有(C) Microsoft Corporation。保留所有权利。

用法: cl [ 选项... ] 文件名... [ /link 链接选项... ]
PS C:\Users\A1387\Desktop> msbuild
适用于 .NET Framework MSBuild 版本 17.11.2+c078802d4
MSBUILD : error MSB1003: 请指定项目或解决方案文件。当前工作目录中未包含项目或解决方案文件。
PS C:\Users\A1387\Desktop> dumpbin
Microsoft (R) COFF/PE Dumper Version 14.41.34120.0
Copyright (C) Microsoft Corporation.  All rights reserved.

用法: DUMPBIN [选项] [文件]
```

[^1]: 微软文档明确指出，直接设置环境变量可能会导致一些不可预测的问题（例如环境污染、查找路径等问题）。因此，他们推荐使用微软提供的预配置终端，而不是通过手动设置环境变量。尽管我们使用临时环境变量不会影响全局环境，但在当前终端中，依然可能会引发意料之外的问题，因为相关目录中包含了大量的文件。为了避免这些问题，我们选择直接使用绝对路径来定义可执行文件，避免依赖环境变量。

## 总结

按需求设置，有问题可以提 pr 与 issue 补充。

以下为我当前的完整设置：

```PowerShell
$global:mq白 = "伟大无需多言🙌👍"

$global:cl = "D:\visual studio 2022\VC\Tools\MSVC\14.41.34120\bin\Hostx64\x64\cl.exe"
$global:msbuild = "D:\visual studio 2022\MSBuild\Current\Bin\amd64\msbuild.exe"
$global:dumpbin = "D:\visual studio 2022\VC\Tools\MSVC\14.41.34120\bin\Hostx64\x64\dumpbin.exe"

function Global:cl{
    return & $cl @args
}

function Global:msbuild{
    return & $msbuild @args
}

function Global:dumpbin{
    return & $dumpbin @args
}

$termWidth = [System.Console]::WindowWidth
$message = "环境加载成功 🎉"
$padding = [Math]::Max(0, ($termWidth - $message.Length) / 2)
Write-Host (" " * $padding + $message) -ForegroundColor Green
```

视频教程：<https://www.bilibili.com/video/BV1YbzrYkEqa>
