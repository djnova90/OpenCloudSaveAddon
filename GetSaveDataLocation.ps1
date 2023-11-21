#OpenCloudSaveAddon by djnova90

#ProfileGlossary
#https://www.pcgamingwiki.com/wiki/Glossary:Game_data
#userprofile -> $env:USERPROFILE -> C:\Users\(YourUserName)

function WebGetData 
{

}

function GoogleCheck
{

}

function ReadAndTransformIn
{
    
}

function EnterVerifyGameName
{
    $EnteredGameName=Read-Host "Enter Game Name"

}

#URL-PCGamingWiki Links - API - https://www.pcgamingwiki.com/wiki/PCGamingWiki:API

#$PageIDLink="https://www.pcgamingwiki.com/w/api.php?action=cargoquery&format=xml&tables=Infobox_game&fields=Infobox_game._pageID%3DPageID&where=Infobox_game._pageName%3D%22Cult%20of%20the%20Lamb%22"
$PageIDLink="https://www.pcgamingwiki.com/w/api.php?action=cargoquery&format=xml&tables=Infobox_game&fields=Infobox_game._pageID%3DPageID&where=Infobox_game._pageName%3D%22Cyberpunk%202077%22"
$SaveGamePathLink="https://www.pcgamingwiki.com/w/api.php?action=parse&format=xml&pageid=$PageID&prop=wikitext"

#RegEX Filters
$regexPatternID='PageID="(\d+)"'
$regexPatternSaveGameLoc='{{Game data\/saves\|Windows\|(.+?\\.+?)}}'
$regexPatternProfileAndLocpath=".*?{{(.+)}}(.*)"

#Get PageID
$response=Invoke-RestMethod -Uri $PageIDLink

$FilterOnPageID=[regex]::Match($response.InnerXml, $regexPatternID)

$PageID=$FilterOnPageID.Groups[1].Value

#Get PCGamingWiki Save Game Path

$response2=Invoke-RestMethod -Uri $SaveGamePathLink

$WikiFullSaveGameLoc=[regex]::Match($response2.InnerXml, $regexPatternSaveGameLoc)


#Get local SaveGamePath

$FilterOnProfilePath=[regex]::Match($WikiFullSaveGameLoc.Groups[1].Value,$regexPatternProfileAndLocpath)

$ProfilePath=$FilterOnProfilePath.Groups[1].Value

if($ProfilePath -eq "p|userprofile")
{
    $UserProfilePath=$env:USERPROFILE
}


$ProfilePath=$FilterOnSaveGameLoc.Groups[1].Value
$SaveGamePath=$UserProfilePath+$FilterOnProfilePath.Groups[2].Value

Write-Host $UserProfilePath
Write-Host $ProfilePath
Write-Host $SaveGamePath








