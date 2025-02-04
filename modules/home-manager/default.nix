{
  pkgs,
  inputs,
  system,
  pkgs-stable,
  ...
}: {
  imports = [
    ./fish
    ./neovim
    ./ghostty
    ./fastfetch
  ];

  #Home Manager configuration goes here
  home = {
    username = "cloudglides";
    homeDirectory = "/home/cloudglides";
    stateVersion = "24.05"; # Check your current Home Manager version
  };

  # Enable basic programs or features
  programs = {
    home-manager.enable = true;
    # Add other program configurations as needed
  };

  # Optional: Add packages
  home.packages = with pkgs; [
    nixos-icons
    pokeget-rs
  ];
}
