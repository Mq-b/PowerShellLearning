# 定制 `PowerShell` 终端

我们的定制并不是说一些美化、插件之类的东西，而是指另一种。

许多的开发环境、IDE 都会提供一些自己定制好的终端，里面有它的所有的设施，我们只需要使用这个终端就行。

比如 `Visual Studio`、`Qt`、`MySql` 等等。

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

打开终端：

```PowerShell
13:11:34
PS C:\Windows\System32\WindowsPowerShell\v1.0> echo $currentTime
13:11:34
PS C:\Windows\System32\WindowsPowerShell\v1.0>
```
