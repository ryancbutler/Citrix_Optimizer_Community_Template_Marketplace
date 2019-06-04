function Test-XMLFile {
    <#
    .SYNOPSIS
    Test the validity of an XML file
    #>
    [CmdletBinding()]
    param (
    [parameter(mandatory=$true)][ValidateNotNullorEmpty()][string]$xmlFilePath
    )
    
    # Check the file exists
    if (!(Test-Path -Path $xmlFilePath)){
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

$templates = Get-ChildItem -Path ".\templates\*.xml" -Recurse -Force

$testCase = $templates | Foreach-Object{@{file=$_}}         
    It "Template <file> should be valid XML" -TestCases $testCase {
        param($file)
        Test-XMLFile $file.FullName|should -be "True"
    }

$testCase = $templates | Foreach-Object{@{file=$_}}         
    It "Template <file> directory should match author" -TestCases $testCase {
        param($file)
        [xml]$XML = get-content $file.FullName
        $metadata = $xml.root.metadata
        $file.directory.name | should -Match $metadata.author
    }

$testCase = $templates | Foreach-Object{@{file=$_}}         
    It "Template <file> should be schemaversion 2.0 or greater" -TestCases $testCase {
        param($file)
        [xml]$XML = get-content $file.FullName
        $metadata = $xml.root.metadata
        $metadata.schemaversion| should -BeGreaterOrEqual 2
    }

$testCase = $templates | Foreach-Object{@{file=$_}}         
    It "Template <file> should have a valid date format (M/DD/YYYY)" -TestCases $testCase {
        param($file)
        [xml]$XML = get-content $file.FullName
        $metadata = $xml.root.metadata
        #(test-date $metadata.lastupdatedate).test| Should -be "True"
        [DateTime]::ParseExact($metadata.lastupdatedate,'M\/dd\/yyyy',$null)
    }

Describe "Duplicate XML file name check "{
    it "Check for unique template file names" {
        $templatecount = $templates | Group-Object name | Where-Object count -gt 1
        $templatecount.count | should -Not -BeGreaterThan 0
    }
}