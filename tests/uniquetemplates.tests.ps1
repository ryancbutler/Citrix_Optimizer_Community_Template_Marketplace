
function Test-XMLFile {
    #Test the validity of an XML file
    [CmdletBinding()]
    param (
        [parameter(mandatory = $true)][ValidateNotNullorEmpty()][string]$xmlFilePath
    )

    # Check the file exists
    if (!(Test-Path -Path $xmlFilePath)) {
        throw "$xmlFilePath is not valid. Please provide a valid path to the .xml fileh"
    }
    # Check for Load or Parse errors when loading the XML file
    $xml = New-Object System.Xml.XmlDocument
    try {
        $xml.Load((Get-ChildItem -Path $xmlFilePath).FullName)
        return $true
    }
    catch [System.Xml.XmlException] {
        Write-Verbose "$xmlFilePath : $($_.toString())"
        return $false
    }
}


Describe 'Check for valid XML' {
    it 'communitymarketplace.xml should be valid XML' {
        Test-XMLFile "$PSScriptRoot\..\communitymarketplace.xml" | should -be "True"
    }
}

[xml]$mpxml = get-content "$PSScriptRoot\..\communitymarketplace.xml"


$displaynames = @()
Select-Xml -Xml $mpxml -XPath "//displayname" | % { $displaynames += $_.Node.InnerText }

$ids = @()
Select-Xml -Xml $mpxml -XPath "//id" | % { $ids += $_.Node.InnerText }


Describe 'Checking for duplicate template entries' {      
    it 'XML should only contain unique displaynames' {
        $dups = ((($displaynames | group | ? { $_.Count -gt 1 }).Values))
        write-host $dups
        $dups.count | Should -not -BeGreaterThan 0
    }
    it 'XML should only contain unique ids' {
        $dups = ((($ids | group | ? { $_.Count -gt 1 }).Values))
        write-host $dups
        $dups.count | Should -not -BeGreaterThan 0
    }

}