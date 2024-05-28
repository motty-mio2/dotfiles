try {
    Import-Module PSReadLine
} catch {
    scoop install PSReadLine
    Import-Module PSReadLine
} finally {
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit
    Set-PSReadLineOption -PredictionViewStyle InlineView

    Set-PSReadLineOption -Colors @{
        "Parameter" = [ConsoleColor]::Cyan
    }
}

try {
    Import-Module posh-git
} catch {
    scoop install posh-git
    Import-Module posh-git
}

try {
    Import-Module PSFzf
} catch {
    scoop install PSFzf
    Import-Module PSFzf
} finally {
    Set-PSFzfOption -PSReadlineChordProvider 'Ctrl+t'
    Set-PSFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
}


Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

$host.ui.RawUI.WindowTitle = "$env:USERNAME@$env:COMPUTERNAME"
