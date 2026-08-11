{pkgs, inputs, config, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    nerd-fonts.fira-code
  ];

  programs.nix-ld.enable = true;
  services.gvfs.enable = true;
  programs.dconf.enable = true;

  services.fstrim.enable = true;

  hardware.bluetooth.enable = true;

  services.gnome.gnome-online-accounts.enable = true;
  services.dbus.packages = [
    pkgs.gnome-online-accounts
    pkgs.gvfs
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 30;

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  console.keyMap = "us";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 50;
      STOP_CHARGE_THRESH_BAT0 = 80;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_BOOST_ON_AC = 1;
      CPU_SCALING_MIN_FREQ_ON_AC = 400000;
      CPU_SCALING_MAX_FREQ_ON_AC = 4000000;

      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
      CPU_SCALING_MAX_FREQ_ON_BAT = 3800000;

      SOUND_POWER_SAVE_ON_BAT = 1;
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  services.power-profiles-daemon.enable = false;
  services.flatpak.enable = true;
  virtualisation.docker.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    cheese
    epiphany
    gnome-characters
    gnome-console
    gnome-contacts
    gnome-klotski
    gnome-mahjongg
    gnome-maps
    gnome-mines
    gnome-music
    gnome-nibbles
    gnome-robots
    gnome-sound-recorder
    gnome-sudoku
    gnome-taquin
    gnome-tetravex
    gnome-tour
    gnome-weather
    simple-scan
    totem
    yelp
  ];

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
    extraGroups = ["networkmanager" "wheel" "docker" "dialout"];
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
    settings = {
      PasswordAuthentication = false;
      ChallengeResponseAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "cloudglides"];
    substituters = [
      "https://cache.nixos.org"
      "https://devenv.cachix.org"
      "https://helium-nix.cachix.org"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "helium-nix.cachix.org-1:a8YPjt9O4GPyX0u3gjg/aWpb14teU9aRiSG/MOaSFgw="
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.optimise.automatic = true;

  environment.systemPackages = with pkgs; [
    rclone
  ];

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    secrets.gitconfig = {
      owner = config.users.users.cloudglides.name;
      mode = "0444";
    };
  };

  system.stateVersion = "24.11";
}
