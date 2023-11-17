#OpenCloudSaveAddon by djnova90

#ProfileGlossary
#https://www.pcgamingwiki.com/wiki/Glossary:Game_data
#userprofile -> $env:USERPROFILE -> C:\Users\(YourUserName)

function WebGetData 
{

}

#URL-PCGamingWiki Links - API - https://www.pcgamingwiki.com/wiki/PCGamingWiki:API

$PageIDLink="https://www.pcgamingwiki.com/w/api.php?action=cargoquery&format=xml&tables=Infobox_game&fields=Infobox_game._pageID%3DPageID&where=Infobox_game._pageName%3D%22Cult%20of%20the%20Lamb%22"
$SaveGamePathLink="https://www.pcgamingwiki.com/w/api.php?action=parse&format=xml&pageid=$PageID&prop=wikitext&section=4"

#RegEX Filters
$regexPatternID='PageID="(\d+)"'
$regexPatternSaveGameLoc='{{Game data\/saves\|Windows\|(.+?\\.+?)}}'
$regexPatternProfile='{{.+}}'

#Get PageID
$response=Invoke-RestMethod -Uri $PageIDLink

$FilterOnPageID=[regex]::Match($response.OuterXML, $regexPatternID)

$PageID=$FilterOnPageID.Groups[1].Value

#Get PCGamingWiki Save Game Path

$response2=Invoke-RestMethod -Uri $SaveGamePathLink

$FilterOnSaveGameLoc=[regex]::Match($response2.InnerXml, $regexPatternSaveGameLoc)

$SaveGamePath=$FilterOnSaveGameLoc.Groups[1].Value

Write-Host $SaveGamePath

#Get local SaveGamePath

$FilterOnProfilePath=[regex]::Match($SaveGamePath,$regexPatternProfile)

$ProfilePath1=$FilterOnProfilePath.Groups[0].Value

if($ProfilePath1 -eq "{{p|userprofile}}")
{
    $UserProfilePath=$env:USERPROFILE
}




