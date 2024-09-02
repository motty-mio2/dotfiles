{
  description = "A very basic flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.cli = pkgs.buildEnv {
        name = "cli";
        paths = with pkgs; [
          bat
          chezmoi
          cloudflared
          fd
          go-task
          jq
          lazygit
          neovim
          oh-my-posh
          starship
          vim
        ];
      };
    };
}
