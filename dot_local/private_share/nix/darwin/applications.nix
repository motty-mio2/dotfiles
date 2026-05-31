{ pkgs, ... }:
{
  # フォントパッケージをここに追加
  fonts.packages = [
    pkgs.hackgen-font
    pkgs.hackgen-nf-font
  ];

  environment.systemPackages = [
    pkgs.colima
    pkgs.docker
    pkgs.git
    pkgs.git-lfs
    pkgs.discord
    pkgs.libreoffice-bin
    pkgs.notion-app
    pkgs.obsidian
    pkgs.slack
    pkgs.tree
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "none"; # 既存のBrewアプリを消したくない場合は "none"
    brews = [
      "mas"
    ];
    casks = [
      "azookey"
      "bambu-studio"
      "kitty"
      "ghostty"
      "zed"
      "wezterm"
      "raycast"
      "visual-studio-code"
      "autodesk-fusion"
      "kicad"
      "vivaldi"
      "karabiner-elements"
      "google-chrome"
      "firefox"
    ];
    masApps = {
      Bitwarden = 1352778147;
      LINE = 539883307;
      RunCat = 1429033973;
    };
  };

  # zshをnix-darwinで管理
  programs.zsh.enable = true;
}
