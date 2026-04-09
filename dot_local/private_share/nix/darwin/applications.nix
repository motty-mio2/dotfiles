{ pkgs, ... }:
{
  # フォントパッケージをここに追加
  fonts.packages = [
    pkgs.hackgen-font
    pkgs.hackgen-nf-font
  ];

  environment.systemPackages = [
    pkgs.git
    pkgs.alacritty
    pkgs.discord
    pkgs.firefox
    pkgs.google-chrome
    pkgs.libreoffice-bin
    pkgs.notion-app
    pkgs.obsidian
    pkgs.raycast
    pkgs.slack
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "none"; # 既存のBrewアプリを消したくない場合は "none"
    casks = [
      "zed"
      "wezterm"
      "visual-studio-code"
      "autodesk-fusion"
      "kicad"
      "vivaldi"
    ];
    masApps = {
      Bitwarden = 1352778147;
      LINE = 539883307;
    };
  };

  # zshをnix-darwinで管理
  programs.zsh.enable = true;
}
