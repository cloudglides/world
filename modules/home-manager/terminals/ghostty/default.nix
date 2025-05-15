{pkgs, ...}: {
  xdg.desktopEntries = {
    "com.mitchellh.ghostty" = {
      name = "Ghostty";
      exec = "ghostty";
      icon = "/etc/icons/ghostty.png";
      terminal = false;
      type = "Application";
      categories = ["Network" "InstantMessaging"];
    };
  };

  home.packages = with pkgs; [
    ghostty
    bat
    neofetch
    jq
    wget
    direnv
    nushell
    zsh
    oh-my-zsh
    btop
    superfile
    exiftool
    gh
    curl
    libdrm
    imagemagick
    sox
    unzip
    p7zip
    lazygit
    devenv
    gnome-keyring
  ];

  # Copy ghostty config and shaders into ~/.config/ghostty
  home.file.".config/ghostty/config" = {
    source = pkgs.cloudglides-ghostty + "/config";
    recursive = true;
  };
  home.file.".config/ghostty/shaders" = {
    source = pkgs.cloudglides-ghostty + "/shaders";
    recursive = true;
  };
}
