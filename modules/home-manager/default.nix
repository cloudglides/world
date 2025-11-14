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
    ./utilities/tmux
    ./utilities/vesktop
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-35.7.5"
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

  services.vicinae = {
    enable = true;
    autoStart = true;
  };

  programs = {
    home-manager.enable = true;
  };

  xdg.desktopEntries = {
    discord = {
      name = "Vesktop";
      exec = "discord";
      icon = "/etc/icons/vencord.png";
      terminal = false;
    };
  };
  services.flatpak.packages = [
    "org.vinegarhq.Sober"
    "com.stremio.Stremio"
    "in.cinny.Cinny"
  ];
  home.packages = with pkgs; [
    nodejs_20
    zig_0_13
    jjui
    jujutsu
    nixos-icons
    pokeget-rs
    qemu
    vesktop
    tailscale
    qbittorrent-enhanced
    brave
    bun
    zed
    spicetify-cli
    wl-clipboard
    qbittorrent-enhanced
    gemini-cli
    niri
    tmux
    inputs.hayase.packages.${pkgs.system}.default
    inputs.helium.defaultPackage.${pkgs.system}
    inputs.nixcord.packages
    cargo-tauri
    discord-ptb
    pnpm
    wakatime-cli
  ];
}
