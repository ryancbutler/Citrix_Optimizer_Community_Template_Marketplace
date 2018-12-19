[xml]$mpxml = get-content "$env:APPVEYOR_BUILD_FOLDER\template.xml"

$rooturl = "https://raw.githubusercontent.com/ryancbutler/Citrix_Optimizer_Community_Template_Marketplace/master/templates"

$templates = Get-ChildItem -Path "$env:APPVEYOR_BUILD_FOLDER\templates\*.xml" -Recurse -Force
$templatesxml = $mpxml.CreateElement("templates")
$tempxml = $mpxml.root.AppendChild($templatesxml)
foreach ($template in $templates)
{
    
    [xml]$XML = get-content $template.FullName
    $metadata = $xml.root.metadata

    $newtemplatexml = $mpxml.CreateElement("template")
    $newtemplate = $tempxml.AppendChild($newtemplatexml)

    $newtemp = [ordered]@{
    id = $metadata.id
    version = $metadata.version
    displayname = $metadata.displayname
    description = $metadata.description
    category = $metadata.category
    author = $metadata.author
    updatedate  = $metadata.lastupdatedate
    url = "$rooturl/$($metadata.author -replace " ","%20")/$($template.name)"
    }

    $newtemp.Keys | ForEach-Object {
        write-host $_
        $newXmlElement = $newtemplate.AppendChild($mpxml.CreateElement($_));
        $newXmlTextNode = $newXmlElement.AppendChild($mpxml.CreateTextNode($newtemp.Item($_)));
    }

    $newXmlChecksumElement = $newtemplatexml.AppendChild($mpxml.CreateElement("checksum"));
}


$mpxml.Save("$env:APPVEYOR_BUILD_FOLDER\communitymarketplace.xml")