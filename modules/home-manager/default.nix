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
  xdg.desktopEntries = {
    vesktop = {
      name = "Vesktop";
      exec = "vesktop";
      icon = "/home/cloudglides/Downloads/vencord.png";
      terminal = false;
      type = "Application";
      categories = ["Network" "InstantMessaging"];
    };
    miru = {
      name = "Miru";
      exec = "miru";
      icon = "/home/cloudglides/Downloads/neko.png";
      terminal = false;
      type = "Application";
      categories = ["Network" "InstantMessaging"];
    };
    zen = {
      name = "Zen";
      exec = "zen";
      icon = "/home/cloudglides/Downloads/Zen-Dark-LightAcc-1024.ico";
      terminal = false;
      type = "Application";
      categories = ["Network" "InstantMessaging"];
    };
    obsidian = {
      name = "Obsidian";
      exec = "obsidian";
      icon = "/home/cloudglides/Downloads/obsidian.png";
      terminal = false;
      type = "Application";
      categories = ["Network" "InstantMessaging"];
    };
  };

  # Packages
  home.packages = with pkgs; [
    nixos-icons
    pokeget-rs
    inputs.zen-browser.packages.x86_64-linux.default
    niri
    imagemagick
    devenv
    vesktop
    nodejs_18
  ];
}
