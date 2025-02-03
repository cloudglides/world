{
  description = "NixOS and Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:pfaj/zen-browser-flake";

    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    spicetify,
    zen-browser,
    nur,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-stable = nixpkgs-stable.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs system;
        pkgs-stable = pkgs-stable;
      };
      modules = [
        ./modules/nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs system;
              pkgs-stable = pkgs-stable;
            };
            users.cloudglides = import ./modules/home-manager;
          };
        }
      ];
    };

    homeConfigurations.cloudglides = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./modules/home-manager
        ({pkgs, ...}: {
          nixpkgs.overlays = [nur.overlay];
        })
      ];
      extraSpecialArgs = {
        inherit inputs system;
        pkgs-stable = pkgs-stable;
      };
    };
  };
}
