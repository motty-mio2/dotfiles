$configure_folder = "$Env:USERPROFILE\.config\powershell"

foreach ($subdir in "conf", "completion") {
    $path = Join-Path $configure_folder $subdir
    if (Test-Path $path) {
        [System.IO.Directory]::GetFiles($path, "*.ps1", "AllDirectories") | ForEach-Object {
            . $_
        }
    }
}
