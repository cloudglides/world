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
    helium.url = "github:cloudglides/helium-nix/main";
    lookout.url = "github:cloudglides/lookout-nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nixcord.url = "github:kaylorben/nixcord";

    opencode.url = "github:sst/opencode";

    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";

    overlay = final: prev: {
      cloudglides-nvim = final.callPackage ./pkgs/neovim {};
      cloudglides-ghostty = final.callPackage ./pkgs/ghostty {};
      cloudglides-opencode = final.callPackage ./pkgs/opencode {};
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./modules/nixos/configuration.nix

        inputs.sops-nix.nixosModules.sops

        {
          nixpkgs = {
            overlays = [
              overlay
              inputs.helium.overlays.default
            ];

            config = {
              allowUnfree = true;

              permittedInsecurePackages = [
                "electron-40.10.5"
              ];
            };
          };
        }

        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";

            extraSpecialArgs = {
              inherit inputs;
            };

            users.cloudglides = {
              imports = [
                ./modules/home-manager/default.nix
                inputs.nix-flatpak.homeManagerModules.nix-flatpak
              ];
            };
          };
        }

        {
          environment.etc."icons".source = ./assets/icons;
        }
      ];
    };
  };
}
