{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zephyr.url = "github:zmkfirmware/zephyr/v3.5.0+zmk-fixes";
    zephyr.flake = false;
    zephyr-nix.url = "github:nix-community/zephyr-nix";
    zephyr-nix.inputs.zephyr.follows = "zephyr";
    zephyr-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, zephyr-nix, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          zephyr = zephyr-nix.packages.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            packages = [
              zephyr.pythonEnv
              (zephyr."sdk-0_16".override { targets = [ "arm-zephyr-eabi" ]; })

              pkgs.cmake
              pkgs.dtc
              pkgs.ninja
              pkgs.just
              pkgs.yq
              pkgs.gawk
              pkgs.unixtools.column
              pkgs.coreutils 
              pkgs.diffutils
              pkgs.findutils
              pkgs.gnugrep
              pkgs.gnused
            ];

          };
        }
      );
    };
}
