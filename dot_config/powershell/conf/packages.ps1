if (Get-Command mise -ErrorAction SilentlyContinue) {
    mise activate pwsh --cd $Env:USERPROFILE | Out-String | Invoke-Expression
}

function mupdate {
    $tokenSet = $false
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        $status = gh auth status --active --hostname github.com 2>&1
        if ($LASTEXITCODE -eq 0 -and $status) {
            $env:MISE_GITHUB_TOKEN = gh auth token
            $tokenSet = $true
        }
    }

    try {
        mise self-update --quiet
        mise upgrade --bump
        mise cache prune
    } finally {
        if ($tokenSet) {
            Remove-Item Env:\MISE_GITHUB_TOKEN
        }
    }
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
    $file = Join-Path $Env:USERPROFILE ".config\scoop\cli.json"
    if (Test-Path $file) {
        scoop import $file
    } else {
        Write-Warning "Scoop CLI configuration not found: $file. Run chezmoi apply first."
    }
}

function Install-Scoop-Dev-Tools {
    $file = Join-Path $Env:USERPROFILE ".config\scoop\dev.json"
    if (Test-Path $file) {
        scoop import $file
    } else {
        Write-Warning "Scoop dev configuration not found: $file. Run chezmoi apply first."
    }
}

function Install-Scoop-GUI-Tools {
    $file = Join-Path $Env:USERPROFILE ".config\scoop\gui.json"
    if (Test-Path $file) {
        scoop import $file
    } else {
        Write-Warning "Scoop GUI configuration not found: $file. Run chezmoi apply first."
    }
}

function sprune {
    scoop prune @args
}

function Apply-Windows-Registry {
    $file = Join-Path $Env:USERPROFILE ".config\winget\registry.dsc.yaml"
    if (Test-Path $file) {
        winget configure -f $file --accept-configuration-agreements
    } else {
        Write-Warning "WinGet registry configuration file not found: $file. Run chezmoi apply first."
    }
}

function Apply-Windows-Packages {
    $file = Join-Path $Env:USERPROFILE ".config\winget\packages.dsc.yaml"
    if (Test-Path $file) {
        winget configure -f $file --accept-configuration-agreements
    } else {
        Write-Warning "WinGet packages configuration file not found: $file. Run chezmoi apply first."
    }
}

function Install-Windows-Software {
    Apply-Windows-Packages
}

