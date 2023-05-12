$configure_folder = $HOME + "\.local\share\chezmoi\tools\windows\conf"

Get-ChildItem -Path ($configure_folder) -Recurse -Include *.ps1 | ForEach-Object -Process {
    Invoke-Expression (". " + $_)
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

#Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
#Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
#Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

