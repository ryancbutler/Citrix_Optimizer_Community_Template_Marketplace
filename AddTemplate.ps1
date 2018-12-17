[xml]$XML = get-content ".\Citrix_Windows_10_1709.xml"
[xml]$mpxml = get-content ".\communitymarketplace.xml"

$metadata = $xml.root.metadata

$newtemplate = $mpxml.root.templates.AppendChild($mpxml.CreateElement("template"))

$newtemp = [ordered]@{
id = $metadata.id
version = $metadata.version
displayname = $metadata.displayname
description = $metadata.description
category = $metadata.category
author = $metadata.author
updatedate  = $metadata.lastupdatedate
url = "https://ctxsym.citrix.com/supportabilitytools/citrixoptimizer/templates/Citrix_Windows_10_1607.xml"
checksum = "" 
beta = "true"
}

$newtemp.Keys | % {
write-host $_
$newXmlElement = $newtemplate.AppendChild($mpxml.CreateElement($_));
$newXmlTextNode = $newXmlElement.AppendChild($mpxml.CreateTextNode($newtemp.Item($_)));
}

$mpxml.Save(".\communitymarketplace3.xml")