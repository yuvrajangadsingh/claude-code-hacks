#!/bin/bash
# Share your Claude Code login to another Mac. No browser needed.
#
# Usage (paste in Terminal):
#   curl -sL https://raw.githubusercontent.com/yuvrajangadsingh/claude-code-hacks/main/share-login.sh | bash
#
# What happens:
#   1. Extracts your Claude Code credentials from Keychain
#   2. Strips out everything except login info (no MCP tokens)
#   3. Copies a transfer command to your clipboard
#   4. Send that to whoever needs it, they paste it in Terminal

RAW=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null)

if [ -z "$RAW" ]; then
  echo ""
  echo "  Could not find Claude Code credentials."
  echo "  Make sure Claude Code is installed and you're logged in."
  echo "  Run 'claude' first, then try again."
  echo ""
  exit 1
fi

# strip mcp tokens, keep only auth. plutil ships with every mac since 10.2.
INNER=$(printf '%s' "$RAW" | plutil -extract claudeAiOauth json - -o - 2>/dev/null)
if [ -n "$INNER" ]; then
  AUTH="{\"claudeAiOauth\":$INNER}"
else
  AUTH="$RAW"
fi

# base64 encode to avoid quoting issues with special characters
B64=$(printf '%s' "$AUTH" | base64)

# leading space skips shell history on most shells
CMD=" security delete-generic-password -s \"Claude Code-credentials\" 2>/dev/null; security add-generic-password -s \"Claude Code-credentials\" -a \"\$(whoami)\" -w \"\$(echo '$B64' | base64 -d)\" && echo 'Done. Run: claude'"

if printf '%s' "$CMD" | pbcopy 2>/dev/null; then
  echo ""
  echo "  Copied to clipboard."
  echo "  Send it to whoever needs to login."
  echo "  They paste it in Terminal and run 'claude'."
  echo ""
else
  echo ""
  echo "  Could not copy to clipboard. Here's the command:"
  echo ""
  echo "$CMD"
  echo ""
fi
