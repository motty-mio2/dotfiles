Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

powershell -NoProfile Install-Module -Name PSReadLine -Scope CurrentUser -Force
pwsh -NoProfile Install-Module -Name PSReadLine -Scope CurrentUser -Force

# Install Scoop
Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
scoop reset

scoop bucket add extras
scoop bucket add github-gh
scoop bucket add java
scoop bucket add viewer
scoop bucket add nonportable
scoop bucket add versions
scoop bucket add nerd-font
scoop bucket add hdl https://github.com/motty-mio2/mio2_bucket.git

scoop install 7zip bat chezmoi fd fzf gh git gsudonano less make neovim oh-my-posh posh-git svlint svls volta wezterm wget which

scoop alias add upgrade 'scoop update && scoop update *' 'update all'
scoop alias add backup 'scoop export > ~\scoop.txt'
scoop alias add reinstall "scoop uninstall {0}; scoop install {0}"

sudo sc config "Audiosrv" start= auto

# winget install Microsoft.OpenSSH.Beta --override ADDLOCAL=Client

# エクスプローラ周り重い人向け覚書
# https://forest.watch.impress.co.jp/docs/serial/yajiuma/1523696.html

# C:\Program Files\Windows Defender\MsMpEng.exe を除外パスに追加
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths" /v "C:\Program Files\Windows Defender\MsMpEng.exe" /t REG_DWORD /d "0" /f
# MsMpEng.exe を除外プロセスに追加
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Processes" /v "MsMpEng.exe" /t REG_DWORD /d "0" /f
# C:\Program Files\Windows Defender\MsMpEng.exe の除外パス設定をクエリ
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths" /v "C:\Program Files\Windows Defender\MsMpEng.exe"
# MsMpEng.exe の除外プロセス設定をクエリ
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Exclusions\Processes" /v "MsMpEng.exe"

# 「ときどきスタートにおすすめを表示する」をオフに設定
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
# 「スタートメニューまたはタスクバーのジャンプリストに最近開いた項目を表示する」をオフに設定
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f
# タスクバーのPeopleの内容をオフに設定
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d "0" /f

# 「エクスプローラで開く」を「PC」に設定
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f
# 「プライバシー」チェックを両方とも外す
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f
# 「隠しファイル、隠しフォルダー～」チェックをオンに設定
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f
# 「フォルダーとデスクトップの項目の説明を～」をオフに設定
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowInfoTip" /t REG_DWORD /d "0" /f
# 「フォルダーのヒントに」をオフに設定
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "FolderContentsInfoTip" /t REG_DWORD /d "0" /f
# 「空のドライブは表示しない」をオンに設定
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideDrivesWithNoMedia" /t REG_DWORD /d "1" /f
# 「登録されている拡張子は表示しない」をオフに設定
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f
