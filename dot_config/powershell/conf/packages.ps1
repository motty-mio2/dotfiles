if (Get-Command mise -ErrorAction SilentlyContinue) {
    mise activate pwsh --cd $Env:USERPROFILE | Out-String | Invoke-Expression
}

function mupdate {
    mise self-update --quiet
    mise upgrade --bump
    mise cache prune
}

function supdate {
    scoop update
    scoop update *
    scoop cleanup *
}

function wupdate {
    winget upgrade $args
}


function Install-rust-Tools {
    $components = (chezmoi execute-template '{{.dependencies.rustup | join " " }}') -split '\s+' | Where-Object { $_ }
    if ($components.Count -gt 0) {
        rustup component add $components
    }
}

function Install-uv-Tools {
    param (
        $UV_ENV = "$env:USERPROFILE\.local\bin",
        $executableName = "uv.exe"
    )

    $tools = (chezmoi execute-template '{{- .dependencies.pip | join " " -}}') -split '\s+' | Where-Object { $_ }
    foreach ($tool in $tools) {
        & "$UV_ENV\$executableName" tool install --upgrade $tool
    }

    & "$UV_ENV\$executableName" tool install --upgrade --from git+https://github.com/motty-mio2/dixp dixp
}

function Install-Scoop-Tools {
    $pkgs = (chezmoi execute-template '{{ range $name, $managers := .dependencies.cli -}}{{- if and (hasKey $managers "scoop") (not (hasKey $managers "mise")) -}}{{- get $managers "scoop" | printf "%s " -}}{{- end -}}{{- end }}') -split '\s+' | Where-Object { $_ }
    scoop install $pkgs
}

function Install-Scoop-Dev-Tools {
    $pkgs = (chezmoi execute-template '{{ range $name, $managers := .dependencies.dev -}}{{- if and (hasKey $managers "scoop") (not (hasKey $managers "mise")) -}}{{- get $managers "scoop" | printf "%s " -}}{{- end -}}{{- end }}') -split '\s+' | Where-Object { $_ }
    scoop install $pkgs
}

function Install-Scoop-GUI-Tools {
    $pkgs = (chezmoi execute-template '{{ range $name, $managers := .dependencies.desktop -}}{{- if and (hasKey $managers "scoop") (not (hasKey $managers "mise")) -}}{{- get $managers "scoop" | printf "%s " -}}{{- end -}}{{- end }}') -split '\s+' | Where-Object { $_ }
    $default_pkgs = @("7zip", "geekuninstaller", "gsudo", "sysinternals")
    foreach ($pkg in ($default_pkgs + $pkgs)) {
        if ($pkg) {
            scoop install $pkg
        }
    }
}

function Install-Windows-Software {
    # OpenSSH
    winget install --id Microsoft.OpenSSH.Beta --override ADDLOCAL=Client

    # PowerShell
    winget install --id  Microsoft.PowerShell

    # PowerToys
    winget install --id XP89DCGQ3K6VLD

    # Visual Studio Code
    winget install --id Microsoft.VisualStudioCode --override "/VERYSILENT /NORESTART /MERGETASKS=!runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"

    # Install Apps
    $wingetPkgs = (chezmoi execute-template '{{- range $name, $managers := .dependencies.desktop -}}{{- if get $managers "winget" -}}{{ get $managers "winget" | printf "%s " }}{{- end -}}{{- end -}}') -split '\s+' | Where-Object { $_ }
    foreach ($pkg in $wingetPkgs) {
        winget install --id $pkg
    }
}
