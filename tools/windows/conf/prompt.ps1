Import-Module PSReadLine
Import-Module (Join-Path $HOME "\scoop\modules\posh-git")

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit

Set-PSReadLineOption -PredictionViewStyle InlineView


#Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
#Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
#Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }


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
