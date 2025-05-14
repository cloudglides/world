{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./terminals/fish
    ./editors/neovim
    ./terminals/ghostty
    ./utilities/fastfetch
    inputs.zen-nebula.homeModules.default
  ];

  zen-nebula = {
    enable = true;
    profile = "yxcu92v3.Default Profile";
  };

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
    config = {
      global = {
        warn_timeout = "0";
        hide_env_diff = true;
      };
    };
  };

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
    };
    zen = {
      name = "Zen";
      exec = "zen";
      icon = "/etc/icons/zen.ico";
      terminal = false;
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
    nodejs_20
    sox
    qbittorrent-enhanced
    zed
    qemu
    nushell
    bat
    neofetch
    jq
    wget
    stremio
    jujutsu
    jjui
    direnv
    elixir-ls
    windsurf
    chromium
    fish
    brave
    git
    gnome-tweaks
    miru
    auto-cpufreq
    zsh
    zig
    unzip
    p7zip
    spicetify-cli
    spotify
    wl-clipboard
    oh-my-zsh
    wakatime-cli
    lua-language-server
    btop
    superfile
    exiftool
    gh
    affine
    curl
    gnome-keyring
    libdrm
  ];
}
