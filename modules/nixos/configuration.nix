{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  programs.nix-ld.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableAllFirmware = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-35.7.5"
  ];

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
    settings = {
      PasswordAuthentication = true;
      ChallengeResponseAuthentication = true;
    };
  };
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

  environment.systemPackages = with pkgs; [
    tlp
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
