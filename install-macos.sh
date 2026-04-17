#!/bin/bash
# macOS system preferences: keyboard repeat + Caps Lock → Ctrl remap.
# Changes to NSGlobalDomain take full effect after logout/login.
set -euo pipefail

cd "$(dirname "$0")"

# -- keyboard repeat (as fast as possible) -------------------------------------
# KeyRepeat: 1 is below the GUI minimum of 2 (fastest practical).
# InitialKeyRepeat: 10 is below the GUI minimum of 15 (shortest delay).
# ApplePressAndHoldEnabled=false: disables the accent-picker popup so key repeat
#   works in every app (Chrome/VS Code/etc).
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# -- Caps Lock → Left Control --------------------------------------------------
# hidutil applies immediately but doesn't persist across reboots on its own.
# A LaunchAgent reapplies the mapping at login.
#   0x700000039 = Caps Lock
#   0x7000000E0 = Left Control
REMAP='{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}'

hidutil property --set "$REMAP" >/dev/null

mkdir -p ~/Library/LaunchAgents
PLIST=~/Library/LaunchAgents/com.local.capslocktoctrl.plist
cat > "$PLIST" <<PLIST_EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.local.capslocktoctrl</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/hidutil</string>
        <string>property</string>
        <string>--set</string>
        <string>${REMAP}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
PLIST_EOF

# Reload the agent so changes to the plist take effect
launchctl unload "$PLIST" 2>/dev/null || true
launchctl load "$PLIST"
