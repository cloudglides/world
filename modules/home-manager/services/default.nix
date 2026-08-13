{ config, pkgs, inputs, ... }:

# Proton Mail Bridge module
# Requires Proton Mail paid plan (Unlimited, Business, or Legacy)
# Download Bridge: https://proton.me/mail/bridge
#
# After installation:
# 1. Start Proton Mail Bridge
# 2. Account → Copy password → Save this Bridge password
# 3. Update ~/.config/opencode/mcp-config.json with credentials
# 4. Run: home-manager switch

proton-mail-bridge = {
  enable = false;  # Set true after Bridge installed

  installPath = "/opt/proton-mail-bridge";

  # Post-installation: auto-start Bridge
  # (managed manually or via systemd on NixOS)
};
