{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.dev = pkgs.buildEnv {
        name = "dev";
        paths = with pkgs; [
          arduino-language-server
          hadolint
          nixfmt-rfc-style
          sccache
          shellcheck
          shfmt
          stylua
          svlint
          svls
          verible
        ];
      };
    };
}
