# oh-my-posh init pwsh --config $PSScriptRoot\theme.omp.json | Invoke-Expression
# Enable-PoshTransientPrompt

Import-Module PSReadLine
Import-Module (Join-Path $HOME "\scoop\modules\posh-git")

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit

Set-PSReadLineOption -PredictionViewStyle InlineView
