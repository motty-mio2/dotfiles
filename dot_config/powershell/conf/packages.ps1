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

function Prune-Scoop-Tools {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [switch]$Uninstall,
        [switch]$Force
    )

    if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
        Write-Warning "Scoop is not installed."
        return
    }

    $exportJson = scoop export | ConvertFrom-Json
    $installed = $exportJson.apps.Name
    if (-not $installed) {
        Write-Host "No Scoop packages are currently installed."
        return
    }

    $defined = @()
    foreach ($f in @("cli.json", "dev.json", "gui.json")) {
        $p = Join-Path $Env:USERPROFILE ".config\scoop\$f"
        if (Test-Path $p) {
            $json = Get-Content $p -Raw | ConvertFrom-Json
            if ($json.apps) {
                $defined += $json.apps.Name
            }
        }
    }
    $defined = $defined | Select-Object -Unique

    if ($defined.Count -eq 0) {
        Write-Warning "No defined packages found in ~/.config/scoop/. Run 'chezmoi apply' first."
        return
    }

    $unmanaged = $installed | Where-Object { $defined -notcontains $_ }

    if (-not $unmanaged -or $unmanaged.Count -eq 0) {
        Write-Host "No unmanaged Scoop packages found. All installed packages are tracked by dotfiles!" -ForegroundColor Green
        return
    }

    Write-Host "Found $($unmanaged.Count) unmanaged Scoop package(s) (installed locally but not in dotfiles):" -ForegroundColor Yellow
    foreach ($pkg in $unmanaged) {
        Write-Host "  - $pkg"
    }

    if ($Uninstall) {
        foreach ($pkg in $unmanaged) {
            if ($Force -or $PSCmdlet.ShouldProcess($pkg, "Uninstall unmanaged Scoop package")) {
                Write-Host "Uninstalling $pkg..." -ForegroundColor Cyan
                scoop uninstall $pkg
            }
        }
    } else {
        Write-Host "`nTo uninstall these packages, run: Prune-Scoop-Tools -Uninstall" -ForegroundColor Cyan
        Write-Host "Or use alias: sprune -Uninstall" -ForegroundColor DarkGray
    }
}

Set-Alias sprune Prune-Scoop-Tools

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

