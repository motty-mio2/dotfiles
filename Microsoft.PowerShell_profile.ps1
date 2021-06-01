Get-ChildItem -Path (Join-Path (Split-Path $profile -Parent) "\conf\") -Name -Recurse -Include *.ps1 | ForEach-Object -Process {
    Invoke-Expression (". " + (Join-Path (Split-Path $profile -Parent) "\conf\") + $_)
}

if (Test-Path (Join-Path (Split-Path $profile -Parent) "\addon\")) {
    Get-ChildItem -Path (Join-Path (Split-Path $profile -Parent) "\addon\") -Name -Recurse -Include *.ps1 | ForEach-Object -Process {
        Invoke-Expression (". " + (Join-Path (Split-Path $profile -Parent) "\addon\") + $_)
    }
}