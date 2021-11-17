Import-Module posh-git
Import-Module oh-my-posh
Import-Module PSReadLine

function global:prompt {
    # $user = $env:UserName
    # $now = Get-Date -format "MM/dd HH:mm:ss"
    $now = Get-Date -format "HH:mm:ss"
    $loc = (Get-Location).ToString().Replace($HOME, "~")

    $branch = ((git branch --contains) 2>&1).toString()

    # Write-Host("[" + $user + "] ") -nonewline -foregroundcolor DarkGreen
    Write-Host("(" + $now + ") ") -nonewline -foregroundcolor DarkYellow
    Write-Host($loc + " ") -nonewline -foregroundcolor DarkBlue

    if (-Not $branch.Contains("fatal: not a git repository")) {
        $name = $branch.split(" ")[1]
        $status = git status
        if ($status.Contains("Changes not staged for commit:")) {
            $name += " *"
        }
        elseif ($status.Contains("Changes to be committed:")) {
            $name += " +"
        }
        Write-Host("(" + $name + ") ") -nonewline -ForegroundColor Red
    }
    return "> "
}

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit
