Import-Module posh-git
Import-Module oh-my-posh
Import-Module PSReadLine
function global:prompt {
    $user = $env:UserName
    # $now = Get-Date -format "MM/dd HH:mm:ss"
    $now = Get-Date -format "HH:mm:ss"
    $loc = Get-Location

    Write-Host("[" + $user + "] ") -nonewline -foregroundcolor DarkGreen
    Write-Host("(" + $now + ")") -nonewline -foregroundcolor DarkYellow
    Write-Host(" " + $loc + " ") -nonewline -foregroundcolor DarkBlue
    return "> "
}

$env:DISPLAY = "localhost:0.0"
$env:PATH = $env:USERPROFILE + "\.poetry\bin" + ";" + $env:PATH
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit
