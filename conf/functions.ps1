#function which {
#gcm $args | fl
#   Get-Command $args | Format-List
#}


function test-func {
    Param($id)
    Write-Host "this comes from test"
    foreach ($item in $args) {
        Write-Host $item
    }
    write-host $name
    if ([string]::IsNullorEmpty($id)) {
        $id = [Guid]::NewGuid().ToString().Substring(0, 8)
    }
    Write-Output "$id"
}

function touch {
    New-Item -type file $args
}
function python3 {
    python $args
}

function pip3 {
    python -m pip $args
}

function rmrf {
    <#
        .DESCRIPTION
        Deletes the specified file or directory.
        .PARAMETER target
        Target file or directory to be deleted.
        .NOTES
        This is an equivalent command of "rm -rf" in Unix-like systems.
    #>
    Param(
        [Parameter(Mandatory = $true)]
        [string]$Target
    )
    Remove-Item -Recurse -Force $Target
}

Set-Alias db Directory_Break

function Directory_Break_Single {
    $Child_Path = Convert-Path $args
    $Parent_Path = Split-Path $Child_Path -parent
    if (Test-Path $Child_Path -PathType Container) {
        $Parent_Path = Split-Path $Child_Path -parent
        Move-Item $Child_Path/* $Parent_Path
        Remove-Item -Recurse $Child_Path
    }
}

function Directory_Break {
    $Child_Path = Convert-Path $args

    if ($Child_Path.GetType().FullName -eq "System.String") {
        Directory_Break_Single $Child_Path
    }
    else {
        foreach ($item in $Child_Path) {
            Directory_Break_Single $item
        }
    }
}

function zipd {
    Param($Directory,
        $Name = (Split-Path -Leaf $Directory)
    )
    $CurrentDir = Convert-Path .
    if ($Directory) {
        $Base_Path = Split-Path -Parent $Directory
        $Archive_Name = Join-Path $Base_Path "$Name.zip"

        while ((Test-Path $Archive_Name)) {
            $Archive_Name = Join-Path $Base_Path ($Name + [Guid]::NewGuid().ToString().Substring(0, 4) + ".zip")
        }

        7z a $Archive_Name (Get-ChildItem $Directory) # > $null
    }
    else {
        Write-Output ("This is 7zip based archive function.`n`tParam is directory.")
    }
}

function zipf {
    Param($file,
        $Name = (Split-Path -Leaf $file)
    )

    if ($Directory) {
        $Base_Path = Split-Path -Parent $Directory
        $Archive_Name = Join-Path $Base_Path "$Name.zip"

        while ((Test-Path $Archive_Name)) {
            $Archive_Name = Join-Path $Base_Path ($Name + [Guid]::NewGuid().ToString().Substring(0, 4) + ".zip")
        }

        7z a $Archive_Name (Get-ChildItem $Directory) # > $null
    }
    else {
        Write-Output ("This is 7zip based archive function.`n`tParam is directory.")
    }
}


function uzip {
    Param($Archive
    )
    if ($Archive) {
        $Archive_Path = Convert-Path $Archive
        $Archive_Name = [System.IO.Path]::GetFileNameWithoutExtension($args)
        $Base_Dir = Split-Path $Archive_Path -Parent
        $Output_Dir = Join-Path $Base_Dir $Archive_Name

        while ((Test-Path $Output_Dir)) {
            $Output_Dir = Join-Path $Base_Dir ($Archive_Name + [Guid]::NewGuid().ToString().Substring(0, 4))
        }

        7z x -r "-o$Output_Dir" $Archive_Path # > $null
    }
}

function update {
    scoop update
    scoop update *
}

function iv {
    iverilog $args
}

function ivx {
    iverilog -g2012 $args
}

function Current_Dir {
    Write-Output $(Convert-Path .)
}

function codex {
    if ([string]::IsNullorEmpty($Args[0])) {
        # Write-Host "This is empty args"
        code $(Convert-Path .)
    }
    else {
        if (Test-Path (Convert-Path $Args[0]) -PathType Container) {
            # Write-Host "This is folder"
            $Folder = Convert-Path $Args[0]
            # Write-Output $Folder
            # foreach ($item in $Folder) {
            if (Test-Path $Folder\*.code-workspace) {
                Get-ChildItem $Folder\*.code-workspace | ForEach-Object -Process {
                    code $(Convert-Path $_)
                    # break
                }
            }
            else {
                code $(Convert-Path .)
            }
        }
        elseif ((Get-ChildItem $Args[0]).Extension -eq ".code-workspace") {
            # Write-Host "This is workspace"
            code $Args[0]
        }
        else {
            # Write-Host "This is valid file"
            code (Split-Path (Convert-Path $Args[0]) -parent)
        }
    }
}

function mkcd {
    Param ($dir)

    if (-Not (Test-Path -Type Container $dir) ) {
        New-Item -ItemType Directory $dir
    }
    Set-Location $dir
}