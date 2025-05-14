{
  config,
  pkgs,
  ...
}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty-icat";
        source = "/home/cloudglides/Downloads/mai.jpeg";
        padding = {
          top = 0;
          left = 5;
          right = 5;
        };
      };
      display = {
        separator = "";
        size = {
          ndigits = 0;
          binaryPrefix = "si"; # Moved to correct position
        };
        key = {
          width = 4;
        }; # Changed from string to number
      };
      modules = [
        "break"
        {
          type = "colors";
          symbol = "circle";
        }
        "break"
        {
          type = "title";
          key = "";
          color = {
            user = "34";
            host = "34";
          };
          keyColor = "32";
        }
        {
          type = "os";
          key = "";
          format = "{3} ({12})";
          keyColor = "32";
        }
        {
          type = "kernel";
          key = "";
          format = "{1} {2}";
          keyColor = "32";
        }
        "break"
        {
          type = "cpu";
          key = "";
          keyColor = "34";
          freqNdigits = 1;
        }
        {
          type = "board";
          key = "󱤓";
          keyColor = "34";
        }
        {
          type = "gpu";
          key = "󰢮";
          keyColor = "34";
          format = "{2}";
          forceVulkan = true;
          hideType = "integrated";
        }
        {
          type = "memory";
          key = "";
          keyColor = "34";
          format = "{1} / {2}";
        }
        "break"
        {
          type = "wm";
          key = "";
          keyColor = "33";
        }
        {
          type = "theme";
          key = "󰉼";
          keyColor = "33";
        }
        {
          type = "terminal";
          key = "";
          format = "{3}";
          keyColor = "33";
        }
        {
          type = "shell";
          key = "$";
          format = "{1} {4}";
          keyColor = "33";
        }
        {
          type = "display";
          key = "󰹑";
          keyColor = "33";
          compactType = "original";
        }
        "break"
        {
          type = "colors";
          symbol = "circle";
        }
        "break"
      ];
    };
  };
}
