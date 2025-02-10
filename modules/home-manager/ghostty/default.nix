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
        background-opacity = 0.9
        unfocused-split-opacity = .09
        palette = 0=#21222c
        palette = 1=#ef78b6
        palette = 2=#63fad1
        palette = 3=#f1fa8c
        palette = 4=#9e77ff
        palette = 5=#ff79c6
        palette = 6=#8be9fd
        palette = 7=#f8f8f2
        palette = 8=#6272a4
        palette = 9=#ef78b6
        palette = 10=#63fad1
        palette = 11=#ffffa5
        palette = 12=#9e77ff
        palette = 13=#ff92df
        palette = 14=#a4ffff
        palette = 15=#ffffff

        background = 13131b
        foreground = f8f8f2
        cursor-color = f8f8f2
        selection-background = 44475a
        selection-foreground = ffffff
      '';
    };
  };

  xdg.desktopEntries = {
    "com.mitchellh.ghostty" = {
      name = "Ghostty";
      exec = "ghostty";
      icon = "/home/cloudglides/Downloads/ghostty_fixed.png";
      terminal = false;
      type = "Application";
      categories = ["Network" "InstantMessaging"];
    };
  };

  home.packages = with pkgs; [
    ghostty
  ];
}
