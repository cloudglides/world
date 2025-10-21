{
  description = "lil flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-for-stremio.url = "nixpkgs/5135c59491985879812717f4c9fea69604e7f26f";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hayase.url = "github:cloudglides/hayase-nix";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
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
            imports = [./modules/home-manager/default.nix];
          };
        }
        {
          environment.etc."icons".source = ./assets/icons;
        }
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [overlay];
        }
      ];
    };
  };
}
