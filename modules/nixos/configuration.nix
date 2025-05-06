{ config, pkgs, system, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable Nix linker (nix-ld)
  programs.nix-ld.enable = true;

  # Bootloader and EFI settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.enableAllFirmware = true;

  # Hostname and networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # CPU frequency scaling
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
        scaling_min_freq = 400000;
        scaling_max_freq = 3800000;
      };
      charger = {
        governor = "performance";
        turbo = "auto";
        scaling_max_freq = 4000000;
      };
    };
  };
  services.power-profiles-daemon.enable = false;
virtualisation.docker.enable = true;












  # Timezone and Locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  # X Server and GNOME Desktop
  services.xserver = {
    enable = true;
    xkb = { layout = "us"; };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Audio with Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Fish shell
  programs.fish.enable = true;

  # Define user 'cloudglides' (added 'podman' to extraGroups)
  users.users.cloudglides = {
    isNormalUser = true;
    description = "cloudglides";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

security.pam.loginLimits = [
  {
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "65535";
  }
  {
    domain = "*";
    type = "hard";
    item = "nofile";
    value = "65535";
  }
];


services.openssh = {
  enable = true;
  passwordAuthentication = true;   # Enable temporary password login
  challengeResponseAuthentication = true;
};

  # Nix options
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    trusted-users = root cloudglides
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';

  # System packages
  environment.systemPackages = with pkgs; [
    fish
    brave
    git
    neovim
    gnome-tweaks
    miru
    auto-cpufreq
    zsh
    zig
    unzip
    clang
    gcc
    p7zip
    spicetify-cli
    spotify
    home-manager
    wl-clipboard
    fastfetch
    oh-my-zsh
    wakatime-cli
    lua-language-server
    pokeget-rs
    btop
    superfile
    exiftool
    gh
    obsidian
    curl
    gnome-keyring
    libdrm
    ghostty
  ];

nixpkgs.config.allowUnfree = true;
  # Allow unfree packages and state version
  system.stateVersion = "24.11";
}

