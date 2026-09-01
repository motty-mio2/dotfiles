if (Get-Command carapace -ErrorAction SilentlyContinue) {
    carapace --completer | Out-String | Invoke-Expression
}
