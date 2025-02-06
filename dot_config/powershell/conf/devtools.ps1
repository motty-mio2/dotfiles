
function Install-Scoop {
    if ( -not (Get-Command "scoop")) {
        Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
    }

    scoop reset *

    # scoop alias add upgrade 'scoop update; scoop update *' 'update all'
    # scoop alias add backup 'scoop export > ~\scoop.txt'
    # scoop alias add reinstall "scoop uninstall {0}; scoop install {0}"
}

function Install-rust-Tools {
    rustup component add clippy rust-analysis rust-src rust-docs rustfmt rust-analyzer
}

function Install-uv {
    param (
        $url = "https://astral.sh/uv/install.ps1"
    )

    Invoke-RestMethod $url | Invoke-Expression
}
