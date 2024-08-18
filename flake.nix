{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.cli = nixpkgs.legacyPackages.x86_64-linux.buildEnv {
      name = "my-packages-list";
      paths = [
        nixpkgs.legacyPackages.x86_64-linux.hello
      ];
    };
  };
}
