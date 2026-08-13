# Proton Mail Bridge Quick Setup

## You need a Proton Mail paid plan
- Go to: https://proton.me/mail (upgrade if needed)
- Bridge is a paid feature

## Install Bridge

### Option A: .deb (recommended)
```bash
wget -q "https://proton.me/download/bridge" -O /tmp/proton-bridge.deb
sudo dpkg -i /tmp/proton-bridge.deb
systemctl start proton-mail-bridge
systemctl enable proton-mail-bridge
```

### Option B: AppImage (no sudo)
```bash
wget -q "https://proton.me/download/bridge-appimage" -O ~/proton-bridge.AppImage
chmod +x ~/proton-bridge.AppImage
~/proton-bridge.AppImage &
```

## Get Bridge Password
1. Open Proton Mail Bridge app
2. Go to Account → Copy password
3. Save this securely - this is NOT your login password

## Configure opencode MCP
Edit: `nano ~/.config/opencode/mcp-config.json`

Set:
- PROTONMAIL_USERNAME: your-email@protonmail.com
- PROTONMAIL_PASSWORD: [the Bridge password from step 3]

## Restart opencode
After Bridge is running and config updated, restart opencode.

## Test it works
In opencode, you should now have access to:
- search_messages, get_email_by_id, list_messages
- send_email, reply_email, forward_email
- search_emails, get_folders, move_email_to_folder
