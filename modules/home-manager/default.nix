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
    nodejs_24
    zig_0_13
    jjui
    jujutsu
    nixos-icons
    pokeget-rs
    qemu
    tailscale
    qbittorrent-enhanced
    brave
    bun
    zed
    spicetify-cli
    wl-clipboard
    qbittorrent-enhanced
    gemini-cli
    freecad-wayland
    niri
    tmux
    helium
    inputs.lookout.packages.${pkgs.system}.default
    inputs.hayase.packages.${pkgs.system}.default
    cargo-tauri
    discord-ptb
    pnpm
    wakatime-cli
    amp-cli
    proton-vpn
    firefox
    osu-lazer
    blender
    kicad
    antigravity
  ];
}
