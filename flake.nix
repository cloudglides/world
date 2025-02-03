{
  description = "A simple lil flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Custom package repo (update accordingly)
    zen-browser.url = "github:pfaj/zen-browser-flake";
  };

  outputs = {
    nixpkgs,
    home-manager,
    zen-browser,
    ...
  } @ inputs: let
    system = "x86_64-linux"; # Change if needed
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./modules/nixos/configuration.nix
        home-manager.nixosModules.default
      ];
      specialArgs = {inherit inputs system;}; # Pass system to configuration.nix
    };
  };
}
