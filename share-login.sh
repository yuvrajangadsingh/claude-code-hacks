#!/bin/bash
# Share Claude Code login between Macs without opening a browser.
#
# Run this on the Mac that's LOGGED IN to Claude Code.
# It outputs a single command. Copy that command and run it on the other Mac.
#
# - Only shares auth credentials (no MCP tokens or other data)
# - Auto-detects the target machine's macOS username
# - No settings, sessions, or CLAUDE.md files are affected
# - Works with Pro, Max, Teams, and Enterprise subscriptions

set -euo pipefail

TOKEN=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null | \
  python3 -c "import sys,json; d=json.load(sys.stdin); print(json.dumps({'claudeAiOauth':d['claudeAiOauth']}))" 2>/dev/null)

if [ -z "$TOKEN" ]; then
  echo "ERROR: No Claude Code credentials found in keychain."
  echo "Make sure you're logged into Claude Code on this machine."
  exit 1
fi

echo ""
echo "Run this on the other Mac:"
echo ""
echo "security delete-generic-password -s \"Claude Code-credentials\" 2>/dev/null; security add-generic-password -s \"Claude Code-credentials\" -a \"\$(whoami)\" -w '$TOKEN' && claude"
echo ""
