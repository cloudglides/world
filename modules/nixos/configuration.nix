{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  programs.nix-ld.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.enableAllFirmware = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

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

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  services.xserver = {
    enable = true;
    xkb = {layout = "us";};
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.fish.enable = true;

  users.users.cloudglides = {
    isNormalUser = true;
    description = "cloudglides";
    extraGroups = ["networkmanager" "wheel" "docker"];
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
    passwordAuthentication = true; # Enable temporary password login
    challengeResponseAuthentication = true;
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
    trusted-users = root cloudglides
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';

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
    affine
    curl
    gnome-keyring
    libdrm
    ghostty
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";
}
