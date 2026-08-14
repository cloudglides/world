{ config, pkgs, inputs, ... }:
{
  imports = [
    ./terminals/fish
    ./editors/neovim
    ./terminals/ghostty
    ./utilities/fastfetch
    ./utilities/tmux
    ./utilities/vesktop
    ./services
  ];

  programs.gpg = {
    enable = true;
    settings = {
      use-agent = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-tty;
  };

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      include.path = "/run/secrets/gitconfig";
    };
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
    stateVersion = "24.11";
  };

  programs = {
    home-manager.enable = true;
  };

  xdg.desktopEntries = {
    vesktop = {
      name = "vesktop";
      exec = "vesktop";
      icon = "/etc/icons/vencord.png";
      terminal = false;
    };
  };

  programs.neovim.withRuby = false;
  programs.nixcord.discord.vencord.enable = true;

  services.flatpak.packages = [
    "org.vinegarhq.Sober"
    "com.stremio.Stremio"
    "in.cinny.Cinny"
    "com.usebottles.bottles"
    "com.bambulab.BambuStudio"
  ];

  home.packages = with pkgs; [
    beamPackages.erlang
    beamPackages.elixir
    beamPackages.elixir-ls
    inotify-tools
    nodejs_26
    zig_0_13
    jjui
    jujutsu
    nixos-icons
    pokeget-rs
    qemu
    qbittorrent-enhanced
    brave
    bun
    zed
    wl-clipboard
    antigravity-cli
    niri
    helium
    inputs.lookout.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.hayase.packages.${pkgs.stdenv.hostPlatform.system}.default
    cargo-tauri
    discord-ptb
    pnpm
    wakatime-cli
    amp-cli
    proton-vpn
    firefox
    blender
    kicad
    opencode
  ];

  }
