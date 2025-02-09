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
    ./spotify
  ];

  home = {
    username = "cloudglides";
    homeDirectory = "/home/cloudglides";
    stateVersion = "24.05";
  };

  # Enable basic programs or features
  programs = {
    home-manager.enable = true;
  };

  # Custom desktop entries
  xdg.desktopEntries.vesktop = {
    name = "Vesktop";
    exec = "vesktop";
    icon = "/home/cloudglides/Downloads/vesktop.png"; # Using your custom icon
    terminal = false;
    type = "Application";
    categories = ["Network" "InstantMessaging"];
  };

  # Packages
  home.packages = with pkgs; [
    nixos-icons
    pokeget-rs
    inputs.zen-browser.packages.x86_64-linux.default
    niri
    devenv
    vesktop
    nodejs_18
  ];
}
