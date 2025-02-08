# Document for shell setup files

## Files

- unix: `.config/bash`
- windows: `.config/powershell`

|    name     | description                                                |                      unix                      |                                              windows                                              |
| :---------: | ---------------------------------------------------------- | :--------------------------------------------: | :-----------------------------------------------------------------------------------------------: |
|   profile   | Profile file for shell                                     |  [profile.sh](../dot_config/shell/profile.sh)  |                        [profile.ps1](../dot_config/powershell/profile.ps1)                        |
| interactive | Interactive shell settings                                 |                .bashrc / .zshrc                | [Microsoft.PowerShell_profile.ps1](../dot_config/powershell/Microsoft.PowerShell_profile.ps1.ps1) |
|   devenv    | Environment Variables, Alias and Functions for Development |   [devenv.sh](../dot_config/shell/devenv.sh)   |                      [devenv.ps1](../dot_config/powershell/conf/devenv.ps1)                       |
|  devtools   | Development tools (package manager or language tools)      | [devtools.sh](../dot_config/shell/devtools.sh) |                    [devtools.ps1](../dot_config/powershell/conf/devtools.ps1)                     |
|  packages   | Tools installed by package managers                        | [packages.sh](../dot_config/shell/packages.sh) |                    [packages.ps1](../dot_config/powershell/conf/packages.ps1)                     |
|     ime     | IME command line wrapper                                   |                      None                      |                         [ime.ps1](../dot_config/powershell/conf/ime.ps1)                          |
|    shell    | Environment Variables, Alias and Functions for Daily Use   |    [shell.sh](../dot_config/shell/shell.sh)    |                       [shell.ps1](../dot_config/powershell/conf/shell.ps1)                        |
