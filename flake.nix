{
  description = "lil flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-nebula.url = "github:JustAdumbPrsn/Nebula-A-Minimal-Theme-for-Zen-Browser";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        ./modules/nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs;};
            users.cloudglides = import ./modules/home-manager;
          };
        }
        {
          environment.etc."icons".source = ./assets/icons;
        }
        {
          nixpkgs.overlays = [
            (final: prev: {
              cloudglides-nvim = final.callPackage ./pkgs/neovim {};
            })
          ];
        }
      ];
    };
  };
}
