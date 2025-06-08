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

  home.packages = with pkgs; [
    nodejs_20
    zig
    jjui
    jujutsu
    nixos-icons
    pokeget-rs
    inputs.zen-browser.packages.x86_64-linux.default
    qemu
    windsurf
    discord
    qbittorrent-enhanced
    stremio
    brave
    chromium
    zed
    miru
    affine
    spicetify-cli
    spotify
    wl-clipboard
    qbittorrent-enhanced
    niri
    tmux
  ];

  home.file.".config/mimeapps.list" = {
    text = ''
      [Default Applications]
      inode/directory=niri.desktop
    '';
  };
}
