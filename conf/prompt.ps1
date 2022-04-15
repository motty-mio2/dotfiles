Import-Module posh-git
Import-Module oh-my-posh
Import-Module PSReadLine

# Set-PoshPrompt powerlevel10k_classic
Set-PoshPrompt -Theme $PSScriptRoot\theme.omp.json
Enable-PoshTransientPrompt

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit
