class Person {
    # 定义成员
    [string]$FirstName
    [string]$LastName
    
    # 定义构造函数
    Person([string]$firstName, [string]$lastName) {
        $this.FirstName = $firstName
        $this.LastName = $lastName
    }

    # 定义成员函数
    [string] GetFullName() {
        return "$($this.FirstName) $($this.LastName)"
    }
}

# 创建类的对象实例
$person = [Person]::new("John", "Doe")

# 调用成员函数
$fullName = $person.GetFullName()

# 输出结果
Write-Host $fullName
