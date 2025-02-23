{pkgs, ...}: {
  home.file = {
    ".config/ghostty/config" = {
      text = ''
                # Window configuration
        quit-after-last-window-closed = true
        window-theme=ghostty
        gtk-titlebar=false
        cursor-style=underline
        cursor-opacity=0.9
        shell-integration-features=no-cursor
        # Font configuration
        font-family=Berkeley Mono
        font-size = 16.5
        background-opacity = 0.99
        theme=0x96f
      '';
    };
  };

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
  ];
}
