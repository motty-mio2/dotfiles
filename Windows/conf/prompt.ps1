Import-Module posh-git
Import-Module oh-my-posh
Import-Module PSReadLine
function global:prompt {
    $now = Get-Date -format "MM/dd HH:mm"
    $loc = Get-Location
    Write-Host($now + " " + $loc + " ") -nonewline
    return "> "
}

$env:DISPLAY = "localhost:0.0"
$env:PATH = $env:USERPROFILE + "\.poetry\bin" + ";" + $env:PATH
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit
