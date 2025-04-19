#function which {
#gcm $args | fl
#   Get-Command $args | Format-List
#}

function open ($target = (Get-Location).Path) {
    Start-Process $target
}

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

function single2double($Target_Path) {
    $str = Convert-Path $Target_Path
    $out = ""
    for ($i = 0; $i -lt $str.Length - 1; $i++) {
        $out = $out + $str[$i]
        if ( $str[$i] -eq "\" -and $str[$i + 1] -ne "\") {
            $out = $out + "\"
        }
    }

    $out = $out + $str[-1]
    Write-Output $out
}

function wslp ($Target_Path) {
    $out = single2double($Target_Path)

    wsl wslpath -u $out
}

function rmrf ($Target) {
    Remove-Item -Recurse -Force $Target
}

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
    } else {
        foreach ($item in $Child_Path) {
            Directory_Break_Single $item
        }
    }
}

function zipd {
    Param($Directory,
        $Name = (Split-Path -Leaf $Directory)
    )
    if ($Directory) {
        $Base_Path = Split-Path -Parent $Directory
        $Archive_Name = Join-Path $Base_Path "$Name.zip"

        while ((Test-Path $Archive_Name)) {
            $Archive_Name = Join-Path $Base_Path ($Name + [Guid]::NewGuid().ToString().Substring(0, 4) + ".zip")
        }

        7z a $Archive_Name (Get-ChildItem $Directory) # > $null
    } else {
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
    } else {
        Write-Output ("This is 7zip based archive function.`n`tParam is directory.")
    }
}

function zip {
    Param($Archive, $Files)
    Write-Output $Files
    # 7z.exe a $Archive $Files
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

function supdate {
    scoop update
    scoop update *
    scoop cleanup *
}

function wupdate {
    winget upgrade $args
}

function codex {
    if ([string]::IsNullorEmpty($Args[0])) {
        # Write-Host "This is empty args"
        code $(Convert-Path .)
    } else {
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
            } else {
                code $(Convert-Path .)
            }
        } elseif ((Get-ChildItem $Args[0]).Extension -eq ".code-workspace") {
            # Write-Host "This is workspace"
            code $Args[0]
        } else {
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
    Set-Alias db Directory_Break
}

function ln([switch] $s, [string] $filePath, [string] $symlink) {
    if ($s) {
        New-Item -ItemType SymbolicLink -Value $filePath -Path $symlink | Out-Null
    } else {
        New-Item -ItemType HardLink -Value $filePath -Path $symlink | Out-Null
    }
}

try {
    Remove-Alias ls -ErrorAction Stop
} catch {
}

function ls {
    Get-ChildItem $Args | Where-Object { $_.Name -notmatch '^\.' }
}

function lh {
    Get-ChildItem $Args | Where-Object { $_.Name -match '^\.' }
}

Set-Alias ll Get-ChildItem

function lx {
    Get-ChildItem $Args | Where-Object { $_.Name -match '^\.' }
}

function doc {
    docker compose $Args
}

function paste {
    powershell.exe -command "[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8');Get-Clipboard"
}

function bwx {
    try {
        $output = $(bw unlock)
        foreach ($item in $output) {
            if ($item -match "> (?<exec>.*)" ) {
                Invoke-Expression $Matches.exec
            }
        }
    } catch {
        #
    }
}

function Set-Better-Windows {
    # エクスプローラ周り重い人向け覚書
    # https://forest.watch.impress.co.jp/docs/serial/yajiuma/1523696.html

    # C:\Program Files\Windows Defender\MsMpEng.exe を除外パスに追加
    sudo reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths" /v "C:\Program Files\Windows Defender\MsMpEng.exe" /t REG_DWORD /d "0" /f
    # MsMpEng.exe を除外プロセスに追加
    sudo reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Processes" /v "MsMpEng.exe" /t REG_DWORD /d "0" /f
    # C:\Program Files\Windows Defender\MsMpEng.exe の除外パス設定をクエリ
    sudo reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths" /v "C:\Program Files\Windows Defender\MsMpEng.exe"
    # MsMpEng.exe の除外プロセス設定をクエリ
    sudo reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Processes" /v "MsMpEng.exe"
    # 24H2 sudo を有効化、gsudo がないとできないという矛盾はいったん置いておく
    sudo reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Sudo" /v "Enabled" /t REG_DWORD /d "1" /f

    # スタートメニュー
    # 「ときどきスタートにおすすめを表示する」をオフに設定
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
    # 「スタートメニューのプライバシー、おすすめ系」をオフにする
    reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f
    reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f
    reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_IrisRecommendations" /t REG_DWORD /d "0" /f
    reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f
    # 「さらにピン止めを表示する」
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "StartLayout" /t REG_DWORD /d "1" /f

    #タスクバー
    # タスクバーのPeopleの内容をオフに設定
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d "0" /f
    # タスクバーの検索アイコンを非表示
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f
    # タスクバーのタスクビューアイコンを表示
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f
    # タスクバーのウィジェットアイコンを非表示
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d "0" /f
    # 「タスクの終了」ボタンを表示
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v "TaskbarEndTask" /t "REG_DWORD" /d "1" /f

    # エクスプローラー
    # 「エクスプローラで開く」を「PC」に設定
    reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f
    # 「隠しファイル、隠しフォルダー～」チェックをオンに設定
    reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f
    # 「フォルダーとデスクトップの項目の説明を～」をオフに設定
    reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowInfoTip" /t REG_DWORD /d "0" /f
    # 「フォルダーのヒントに」をオフに設定
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "FolderContentsInfoTip" /t REG_DWORD /d "0" /f
    # 「空のドライブは表示しない」をオンに設定
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideDrivesWithNoMedia" /t REG_DWORD /d "1" /f
    # 「タイトルバーに完全なパスを表示する」をオンに設定
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d "1" /f
    # 「ファイル拡張子を表示する」をオンに設定
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "1" /f
    # 「Office.comのファイルを表示する」をオフに設定
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowCloudFilesInQuickAccess" /t REG_DWORD /d "0" /f
}

function Reset-Broken-Windows {
    # https://togetter.com/li/2473163

    sudo sfc /scannow
    sudo DISM /Online /Cleanup-Image /CheckHealth
    sudo DISM /Online /Cleanup-Image /ScanHealth
    sudo DISM /Online /Cleanup-Image /RestoreHealth
}