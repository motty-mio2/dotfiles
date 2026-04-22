{ pkgs, ... }:

{
  # 1. メインユーザーを指定（必須になりました）
  # ターミナルで `whoami` と打って出てくる名前（今回は多分 user ）を入れてください
  system.primaryUser = "user";
  nixpkgs.config.allowUnfree = true;
  # 2. nix-daemon の設定を現代風に修正
  # services.nix-daemon.enable = true;  <-- これは削除
  nix.enable = false; # これだけでOKです

  # NixコマンドやFlakesを有効にする
  nix.settings.experimental-features = "nix-command flakes";

  # プラットフォームと状態バージョンの維持
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
}
