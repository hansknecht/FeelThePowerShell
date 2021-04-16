<#
    .SYNOPSIS
        This  demonstrates XML actions in Powershell
    .DESCRIPTION
        I will add addiitonal items as I build them out.
    .NOTES

    .EXAMPLE
        .\XMLManipulation.ps1
        
#>
BEGIN {
    function SaveABackup($source) {
        Copy-Item $source -Destination "$source.bak"
    }
    function ResetSource($source) {
        Copy-Item "$source.bak" -Destination $source
    }

    function TraverseTheSource($source) {
        [xml]$xml = Get-Content $source
        Write-Host('You can select using the XPath pattern')
        Write-Host(Select-Xml -Xml $xml -XPath '//author')
        Write-Host

        Write-Host('Or use dot notation')
        Write-Host($xml.catalog.book.author)
        Write-Host

        Write-Host('to search for a single node and its content')
        Write-Host(($xml.catalog.book | Where-Object { $_.id -eq 'bk103'}).author)
        Write-Host
        
        Write-Host('To Show the schema under a node pipe to Get-Member')
        Write-Host($xml.catalog.book | Get-Member -MemberType Property)
        Write-Host

    }
    function ChangeElements($source) {
        [xml]$xml = Get-Content $source
        Write-Host("Changing the value of an element is as simple as assiging it and calling save to the source")
        Write-Host("Before: " + ($xml.catalog.book | Where-Object { $_.id -eq 'bk103'}).author)
        ($xml.catalog.book | Where-Object { $_.id -eq 'bk103'}).author = 'Definetly not Eva Corets'
        Write-Host("After: " + ($xml.catalog.book | Where-Object { $_.id -eq 'bk103'}).author)
        $xml.Save($source)
    }

}
PROCESS {
    $source = './books.xml'
    SaveABackup $source
    TraverseTheSource $source
    ChangeElements $source
    ResetSource $source
}

END {

}