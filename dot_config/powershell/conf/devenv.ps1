# Python
Set-Alias python3 python
Set-Alias pip3 pip

function iv {
    iverilog $args
}

function ivx {
    iverilog -g2012 $args
}

function pchezmoi {
    chezmoi -S $Env:HOME/Projects/dotfiles
}

function wget  {
    wget --hsts-file="$Env:XDG_DATA_HOME/wget-hsts" $args
}

function ghf {
    gh repo clone $(gh repo list -L 10000 | fzf).Split("`t")[0]
}

function mygitconfig {
    git config --local user.name "motty"
    git config --local user.email "motty.mio2@gmail.com"
}

function Set-Environemt-Value {
    param (
        $ENV_NAME,
        $ENV_VALUE
    )

    $current_setting = [System.Environment]::GetEnvironmentVariable($ENV_NAME, "User")

    # current_setting が設定されていないならば
    if ($current_setting -eq $null) {
        [System.Environment]::SetEnvironmentVariable("$ENV_NAME", "$ENV_VALUE", "User")
    } elseif ($current_setting -ne $ENV_VALUE) {
        # current_setting が設定されている，かつ，設定されている値が $ENV_VALUE でないならば
        # print して，ユーザにどちらを利用するか確認する
        Write-Host "1) Current Setting: $current_setting"
        Write-Host "2) New Setting:     $ENV_VALUE"
        $answer = Read-Host "Which do you want to use? (1/2)"
        if ($answer -eq "2") {
            [System.Environment]::SetEnvironmentVariable("$ENV_NAME", "$ENV_VALUE", "User")
        }
    }
}

function Set-Environemt-Path {
    param (
        $ENV_NAME,
        $ENV_VALUE
    )

    $current_setting = [System.Environment]::GetEnvironmentVariable($ENV_NAME, "User")

    if (($null -eq $current_setting) -Or (-Not $current_setting.Contains( $ENV_VALUE ))) {
        [System.Environment]::SetEnvironmentVariable("$ENV_NAME", "$ENV_VALUE" + "; " + "$current_setting", "User")
    }
}

function Set-ESP-IDF-Path {
    param (
        $ESP_IDF_PATH = $env:USERPROFILE + "\.espressif"
    )

    Set-Environemt-Value -ENV_NAME "IDF_PATH" -ENV_VALUE "$env:USERPROFILE\esp\esp-idf"
    Set-Environemt-Value -ENV_NAME "IDF_TOOLS_PATH" -ENV_VALUE "$ESP_IDF_PATH"
}

function Set-XDG-Directory {
    Set-Environemt-Value -ENV_NAME "XDG_CONFIG_HOME"    -ENV_VALUE "$env:USERPROFILE\.config"
    Set-Environemt-Value -ENV_NAME "XDG_DATA_HOME"      -ENV_VALUE "$env:USERPROFILE\.local\share"
    Set-Environemt-Value -ENV_NAME "XDG_CACHE_HOME"     -ENV_VALUE "$env:USERPROFILE\.local\cache"
    Set-Environemt-Value -ENV_NAME "XDG_STATE_HOME"     -ENV_VALUE "$env:USERPROFILE\.local\state"
}

function Disable-Vispaly-Venv {
    Set-Environemt-Value -ENV_NAME "VIRTUAL_ENV_DISABLE_PROMPT" -ENV_VALUE "1"
}

function Set-SVLINT-PATH {
    param (
        $SVLINT_CONFIG = $env:USERPROFILE + "\.config\svlint\svlint.toml"
    )

    Set-Environemt-Path -ENV_NAME "SVLINT_CONFIG" -ENV_VALUE $SVLINT_CONFIG
}
