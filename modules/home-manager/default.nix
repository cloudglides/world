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
    discord = {
      name = "Vesktop";
      exec = "discord";
      icon = "/etc/icons/vencord.png";
      terminal = false;
      type = "Application";
      categories = ["Network" "InstantMessaging"];
    };
    miru = {
      name = "Miru";
      exec = "miru";
      icon = "/etc/icons/miru.png";
      terminal = false;
      type = "Application";
      categories = ["Network" "InstantMessaging"];
    };
    zen = {
      name = "Zen";
      exec = "zen";
      icon = "/etc/icons/zen.ico";
      terminal = false;
      type = "Application";
      categories = ["Network" "InstantMessaging"];
    };
    obsidian = {
      name = "Obsidian";
      exec = "obsidian";
      icon = "/etc/icons/obsidian.png";
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
    (discord.override {
      withVencord = true;
    })
    nodejs_18
    sox
    qbittorrent-enhanced
    zed
  ];
}
