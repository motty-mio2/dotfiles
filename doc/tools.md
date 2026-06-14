# Package Managers

|                | Windows | Linux | macOS | system | desktop |
| -------------- | :-----: | :---: | :---: | :----: | :-----: |
| mise           |    o    |   o   |   o   |   x    |    x    |
| Homebrew       |    x    |   x   |   △   |   o    |    o    |
| apt / pacman   |    x    |   o   |   x   |   o    |    o    |
| snap / flatpak |    x    |   o   |   x   |   o    |    o    |
| AUR            |    x    |   o   |   x   |   o    |    o    |
| nix            |    x    |   o   |   o   |   o    |    o    |
| scoop          |    o    |   x   |   x   |   x    |    o    |
| winget         |    o    |   x   |   x   |   o    |    o    |

## common

Use mise as main package manager for all environments.

## Windows

Use scoop and winget as main package manager.

## macOS

Use nix as main package manager.
Use homebrew and mas-cli for some applications from nix-darwin.

## Linux

Use nix as main package manager.
If you can use root permission, you can use mise.
