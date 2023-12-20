$env:EDITOR = "nvim"
$env:DISPLAY = "localhost:0.0"

if (Test-Path ($HOME + "\.config\shell\")) {
    Get-ChildItem -Path ($HOME + "\.config\shell\") -Recurse -Include *.ps1 | ForEach-Object -Process {
        Invoke-Expression (". " + $_)
    }
}
