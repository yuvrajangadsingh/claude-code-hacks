# claude-login-share

Share your Claude Code login to another Mac. No browser needed.

## Usage

```bash
npx claude-login-share
```

That's it. A command gets copied to your clipboard. Send it to whoever needs to login. They paste it in their Terminal.

## How it works

1. Run `npx claude-login-share` on the Mac that's logged in
2. It extracts your Claude Code credentials from Keychain
3. Strips out MCP tokens and local data (only shares auth)
4. Copies a transfer command to your clipboard
5. Send that command to whoever needs it
6. They paste it in Terminal, Claude Code starts

The transfer command auto-detects the target machine's username. No settings, sessions, projects, or CLAUDE.md files are touched on either machine.

## Requirements

- macOS on both machines
- Claude Code installed on both machines
- Logged into Claude Code on the source machine

Works with Pro, Max, Teams, and Enterprise subscriptions.
