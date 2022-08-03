oh-my-posh init pwsh --config $PSScriptRoot\theme.omp.json | Invoke-Expression

# Import-Module C:\Users\kouki\scoop\modules\PSReadLine
Import-Module PSReadLine
Import-Module C:\Users\kouki\scoop\modules\posh-git

Enable-PoshTransientPrompt

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit
