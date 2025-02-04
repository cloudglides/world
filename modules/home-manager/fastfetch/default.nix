{pkgs, ...}: {
  home.file = {
    ".config/fastfetch/config.jsonc" = {
      text = ''
                {
            "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
            "logo": {
            	"source": "~/.config/fastfetch/images/img4.png",
            	"type": "kitty-direct",
            	"padding": {
            		"top": 2,
                        "left": 4
            	}
            },
            "display": {
                "separator": " "
            },
            "modules": [
        	"break",
                "break",
                "break",
        	{
                    "type": "custom",
                    "format": "\u001b[90m  \u001b[31m  \u001b[32m  \u001b[33m  \u001b[34m  \u001b[35m  \u001b[36m  \u001b[37m  "
                },
        	"break",
        	{
                    "type": "title",
                    "keyWidth": 10
                },
                "break",
                {
                    "type": "os",
                    "key": " ",
                    "keyColor": "34",  // = color4
                },
                {
                    "type": "kernel",
                    "key": " ",
                    "keyColor": "34",
                },
                {
                    "type": "packages",
                    // "format": "{} (pacman)",
                    "key": " ",
                    "keyColor": "34",
                },
                {
                    "type": "shell",
                    "key": " ",
                    "keyColor": "34", },
                "break",
                // {
                //     "type": "terminal",
                //     "key": " ",
                //     "keyColor": "34",
                // },
                {
                    "type": "wm",
                    "key": " ",
                    "keyColor": "34",
                },
                // {
                //     "type": "cursor",
                //     "key": " ",
                //     "keyColor": "34",
                // },
                // {
                //     "type": "terminalfont",
                //     "key": " ",
                //     "keyColor": "34",
                // },
                {
                    "type": "uptime",
                    "key": " ",
                    "keyColor": "34",
                },
                {
                    "type": "command",
                    "key": "󱦟 ",
                    "keyColor": "34",
                    "text": "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days"
                },
                // {
                //     "type": "datetime",
                //     "format": "{1}-{3}-{11}",
                //     "key": " ",
                //     "keyColor": "34",
                // },
                {
                    "type": "media",
                    "key": "󰝚 ",
                    "keyColor": "34",
                },
                // "break",
                "break",
                {
                    "type": "cpu",
                    "key": " ",
                    "keyColor": "blue"
                },
                {
                    "type": "gpu",
                    "key": " ",
                    "keyColor": "blue"
                },
                {
                    "type": "memory",
                    "key": " ",
                    "keyColor": "blue"
                },
                "break",
                {
                    "type": "custom",
                    "format": "\u001b[90m  \u001b[31m  \u001b[32m  \u001b[33m  \u001b[34m  \u001b[35m  \u001b[36m  \u001b[37m "
                },
                "break",
                "break",
            ]
        }
      '';
    };
  };

  home.packages = with pkgs; [
    fastfetch
  ];
}
