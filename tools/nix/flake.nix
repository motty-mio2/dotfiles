{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.base = nixpkgs.legacyPackages.x86_64-linux.buildEnv {
      name = "my-packages-list";
      paths = with nixpkgs.legacyPackages.x86_64-linux;
      [
        arduino-language-server
        bat
        chezmoi
        cloudflared
        fd
        go-task
        lazygit
        neovim
        oh-my-posh
        shellcheck
        shfmt
        starship
        stylua
      ];
    };
  };
}
