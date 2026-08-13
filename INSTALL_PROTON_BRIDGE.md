# Proton Mail Bridge Installation Guide

## Requirements
- Proton Mail **paid plan** (Unlimited, Business, or Legacy Professional/Visionary)
- Proton Mail Bridge is a **paid feature** - free accounts cannot use Bridge

## Installation Methods

### Method 1: .deb Package (recommended for NixOS)
```bash
# 1. Download the .deb package
wget -q "https://proton.me/download/bridge" -O /tmp/proton-bridge.deb

# 2. Install
sudo dpkg -i /tmp/proton-bridge.deb

# 3. Launch Proton Mail Bridge
# - Find it in your application menu, OR
systemctl start proton-mail-bridge
systemctl enable proton-mail-bridge

# 4. Sign in with your Proton Mail credentials
# 5. Go to Account → Copy password → Save this Bridge password
```

### Method 2: AppImage (no sudo required)
```bash
# 1. Download and make executable
wget -q "https://proton.me/download/bridge-appimage" -O ~/proton-bridge.AppImage
chmod +x ~/proton-bridge.AppImage

# 2. Run
~/proton-bridge.AppImage &

# 3. Sign in with your Proton Mail credentials
# 5. Go to Account → Copy password → Save this Bridge password
```

## Post-Installation

### 1. Verify Bridge is Running
```bash
# Check process
ps aux | grep proton

# Check local ports (should be listening)
ss -tlnp | grep -E "1143|1025"
# Expected: 127.0.0.1:1143 (IMAP) and 127.0.0.1:1025 (SMTP)
```

### 2. Get Your Bridge Password
- Open Proton Mail Bridge app
- Go to **Account** → **Copy password**
- This is **NOT** your Proton login password
- Save this somewhere secure - you'll need it for opencode MCP config

### 3. Update opencode MCP Config
Edit `~/.config/opencode/mcp-config.json`:

```json
{
  "mcpServers": {
    "protonmail": {
      "command": "bun",
      "args": ["/home/cloudglides/.config/opencode/node_modules/.bin/proton-mail-mcp"],
      "env": {
        "PROTONMAIL_USERNAME": "your-email@protonmail.com",
        "PROTONMAIL_PASSWORD": "your-bridge-password-from-above",
        "PROTONMAIL_HOST": "smtp.protonmail.ch",
        "PROTONMAIL_PORT": "587",
        "IMAP_HOST": "127.0.0.1",
        "IMAP_PORT": "1143",
        "IMAP_SECURE": "false"
      }
    }
  }
}
```

### 4. Restart opencode
After Bridge is running and config is set, restart opencode for MCP tools to load.

### 5. Test MCP Integration
In opencode, you can now use Proton Mail tools:
- `search_messages` - Search your inbox
- `get_email_by_id` - Read a specific email
- `list_messages` - List recent messages
- `send_email` - Send an email (through your Proton Mail SMTP)

## Troubleshooting

### Bridge won't start
- Ensure you have a paid Proton Mail plan
- Check `/tmp/proton-mail-bridge.log` for errors
- Make sure no other app is using ports 1143/1025

### MCP tools can't connect
- Verify Bridge is running (`ps aux | grep proton`)
- Verify the Bridge password is correct (not your login password)
- Ensure IMAP/SMTP ports are correct (1143/1025 on 127.0.0.1)
- Restart opencode after config changes

### Need to change credentials?
1. Update `~/.config/opencode/mcp-config.json` with new password
2. Restart opencode
