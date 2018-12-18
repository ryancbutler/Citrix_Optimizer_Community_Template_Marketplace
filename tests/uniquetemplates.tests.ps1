[xml]$mpxml = get-content ".\communitymarketplace.xml"

$displaynames = @()
Select-Xml -Xml $mpxml -XPath "//displayname"|%{$displaynames += $_.Node.InnerText}

$ids = @()
Select-Xml -Xml $mpxml -XPath "//id"|%{$ids += $_.Node.InnerText}


Describe 'Checking for duplicate template entries' {      
        it 'XML should contain unique display names' {
            $dups = ((($displaynames | group | ?{$_.Count -gt 1}).Values))
            write-host $dups
            $dups.count | Should -not -BeGreaterThan 0
        }
        it 'XML should contain unique ids' {
            $dups = ((($ids | group | ?{$_.Count -gt 1}).Values))
            write-host $dups
            $dups.count | Should -not -BeGreaterThan 0
        }

}