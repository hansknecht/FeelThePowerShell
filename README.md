# FeelThePowerShell
Tester for Powershell items

## Shared Library

### XML Reading and updating
Script to read and update an XML file. This is usefull for automation local installs independent of tools inside Visual Studio for applicaiotns. 

**Reading in a file**

To load a reaonable sized file the Get-Contect with casting to xml works well

```powershell
[xml]$xml = Get-Content $source
```
If you want to list out a specific element and their values in a file you can use XPath

```powershell
Select-Xml -Xml $xml -XPath '//author'
```

You could also use dot notation

```powershell
$xml.catalog.book.author
```

To search for a single node and its content
```powershell
($xml.catalog.book | Where-Object { $_.id -eq 'bk103'}).author
```

To show the schema under a node, pipe to Get-Member the property membertype

```powershell
$xml.catalog.book | Get-Member -MemberType Property
```

For changing elements you navigate to the elment to reset the value. Calling save with the source file
```powershell
$xml.Save($source)
```
You use the same syntax to see an element with the additional assignment operator
```powershell
($xml.catalog.book | Where-Object { $_.id -eq 'bk103'}).author = 'Eva, Corets'
```