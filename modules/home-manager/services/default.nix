{ config, pkgs, ... }:

# Proton Mail Bridge
# Requires Proton Mail paid plan (Unlimited, Business, or Legacy).
# Headless daemon exposing IMAP (127.0.0.1:1143) and SMTP (127.0.0.1:1025).
#
# After install:
#   1. Log in once:  protonmail-bridge --cli login
#      (username/password are your normal Proton credentials; TOTP if 2FA)
#   2. Bridge generates its own password -> Account > Copy password
#   3. Set PROTONMAIL_USERNAME + PROTONMAIL_PASSWORD for the opencode MCP
#   4. Restart opencode

{
  home.packages = [ pkgs.protonmail-bridge ];

  systemd.user.services.protonmail-bridge = {
    Unit = {
      Description = "Proton Mail Bridge (headless daemon)";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive --cli";
      Restart = "on-failure";
      RestartSec = "10";
      Environment = [
        "PROTONMAIL_BRIDGE_KEYCHAIN=plaintext"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%U/bus"
      ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
