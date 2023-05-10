oh-my-posh init pwsh --config $PSScriptRoot\theme.omp.json | Invoke-Expression

Import-Module PSReadLine
Import-Module (Join-Path $HOME "\scoop\modules\posh-git")

Enable-PoshTransientPrompt

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
