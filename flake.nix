{
  description = "lil flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-for-stremio.url = "github:NixOS/nixpkgs/5135c59491985879812717f4c9fea69604e7f26f";
    hayase.url = "github:cloudglides/hayase-nix";
    helium.url = "github:FKouhai/helium2nix/main";
    vicinae.url = "github:vicinaehq/vicinae";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nixcord.url = "github:kaylorben/nixcord";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nixcord,
    ...
  }: let
    system = "x86_64-linux";
    overlay = final: prev: {
      cloudglides-nvim = final.callPackage ./pkgs/neovim {};
      cloudglides-ghostty = final.callPackage ./pkgs/ghostty {};
    };
    pkgs = import nixpkgs {
      inherit system;
      overlays = [overlay];
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        ./modules/nixos/configuration.nix
        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {inherit inputs pkgs;};
          home-manager.users.cloudglides = {
            imports = [
              ./modules/home-manager/default.nix
              inputs.vicinae.homeManagerModules.default
              inputs.nix-flatpak.homeManagerModules.nix-flatpak
              inputs.nixcord.homeModules.default
            ];
          };
        }

        {environment.etc."icons".source = ./assets/icons;}
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [overlay];
        }
        {
          nix.settings = {
            extra-substituters = ["https://vicinae.cachix.org"];
            extra-trusted-public-keys = [
              "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
            ];
          };
        }
      ];
    };
  };
}
