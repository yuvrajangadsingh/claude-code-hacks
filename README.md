# claude-code-hacks

Useful scripts and tricks for Claude Code CLI.

## share-login.sh

Share your Claude Code login between two Macs without opening a browser on the second machine.

### How it works

1. Run `./share-login.sh` on the Mac that's logged in
2. It outputs a single command
3. Copy that command and run it on the other Mac
4. Claude Code starts, logged into your account

### What it does

- Extracts your OAuth credentials from macOS Keychain
- Strips out MCP tokens and other local data (only shares auth)
- Generates a command that auto-detects the target machine's username via `$(whoami)`
- No settings, sessions, projects, or CLAUDE.md files are affected on either machine

### Requirements

- macOS (uses `security` CLI for Keychain access)
- Python 3 (for JSON parsing)
- Claude Code installed on both machines

### Usage

```bash
chmod +x share-login.sh
./share-login.sh
```

Works with Pro, Max, Teams, and Enterprise subscriptions.
