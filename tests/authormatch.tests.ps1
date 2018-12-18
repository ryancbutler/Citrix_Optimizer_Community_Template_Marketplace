$templates = Get-ChildItem -Path ".\templates\*.xml" -Recurse -Force

$testCase = $templates | Foreach-Object{@{file=$_}}         
    It "Template <file> directory should match author" -TestCases $testCase {
        param($file)
        [xml]$XML = get-content $file.FullName
        $metadata = $xml.root.metadata
        $file.directory.name | should -Match $metadata.author
    }