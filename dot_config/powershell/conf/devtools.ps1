function Install-Scoop {
    if ( -not (Get-Command "scoop")) {
        Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
    }

    scoop reset *

    scoop bucket add extras
    scoop bucket add java
    scoop bucket add versions
    scoop bucket add nerd-fonts
    scoop bucket add motty https://github.com/motty-mio2/scoop-bucket.git
}

function Install-uv {
    param (
        $url = "https://astral.sh/uv/install.ps1"
    )

    Invoke-RestMethod $url | Invoke-Expression
}
