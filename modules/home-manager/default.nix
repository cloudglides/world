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
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-35.7.5"
  ];

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
    zen = {
      name = "Zen";
      exec = "zen";
      icon = "/etc/icons/zen.ico";
      terminal = false;
    };
  };

  home.packages = with pkgs; [
    nodejs_20
    zig_0_13
    jjui
    jujutsu
    nixos-icons
    pokeget-rs
    inputs.zen-browser.packages.x86_64-linux.default
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
    windsurf
    inputs.hayase.packages.${pkgs.system}.default
    inputs.helium.defaultPackage.${pkgs.system}
    cargo-tauri
    discord-ptb
    pnpm
  ];
}
