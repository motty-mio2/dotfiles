{ pkgs, ... }:
{
  # フォントパッケージをここに追加
  fonts.packages = [
    pkgs.hackgen-font
    pkgs.hackgen-nf-font
  ];

  environment.systemPackages = [
    pkgs.git
    pkgs.git-lfs
    pkgs.discord
    pkgs.firefox
    pkgs.google-chrome
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
      "azooKey"
    ];
    casks = [
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
    ];
    masApps = {
      Bitwarden = 1352778147;
      LINE = 539883307;
      # Proton_Authenticator = 6741758667;
    };
  };

  # zshをnix-darwinで管理
  programs.zsh.enable = true;
}
