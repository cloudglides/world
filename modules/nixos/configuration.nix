{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable nix-ld for running unpatched binaries
  programs.nix-ld.enable = true;

  # Boot loader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hardware support
  hardware.enableAllFirmware = true;

  # Allow insecure packages if needed
  nixpkgs.config.permittedInsecurePackages = [
    "electron-35.7.5"
  ];

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Tailscale VPN
  services.tailscale.enable = true;

  # Power Management with TLP
  services.tlp = {
    enable = true;
    settings = {
      # Battery charge thresholds (Dell hardware limits: start 50-95%, stop 55-100%)
      START_CHARGE_THRESH_BAT0 = 50;  # 40% not supported by Dell hardware
      STOP_CHARGE_THRESH_BAT0 = 80;

      # CPU settings on AC power
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_BOOST_ON_AC = 1;
      CPU_SCALING_MIN_FREQ_ON_AC = 400000;
      CPU_SCALING_MAX_FREQ_ON_AC = 4000000;

      # CPU settings on battery
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
      CPU_SCALING_MAX_FREQ_ON_BAT = 3800000;

      # Energy-saving features
      SOUND_POWER_SAVE_ON_BAT = 1;
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  # Disable conflicting power management services
  services.power-profiles-daemon.enable = false;

  # Docker virtualization
  virtualisation.docker.enable = true;

  # Localization
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  # X server and desktop environment
  services.xserver = {
    enable = true;
    xkb = {layout = "us";};
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Audio with PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Fish shell
  programs.fish.enable = true;

  # User configuration
  users.users.cloudglides = {
    isNormalUser = true;
    description = "cloudglides";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.fish;
  };

  # Increase file descriptor limits
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

  # SSH server
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      ChallengeResponseAuthentication = true;
    };
  };

  # Nix configuration
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "cloudglides"];
    substituters = [
      "https://cache.nixos.org"
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    tlp
    # Add other packages you need here
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # NixOS version
  system.stateVersion = "24.11";
}
