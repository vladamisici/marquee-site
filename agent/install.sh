#!/bin/sh
# Installs marquee-mcp — the Marquee agent server — into ~/.marquee/bin.
# Universal macOS binary (Apple Silicon + Intel). No sudo, nothing outside ~/.marquee.
set -eu

VERSION="1.1.0"
BASE="https://vladamisici.github.io/marquee-site/agent"
DEST="$HOME/.marquee/bin"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "Downloading marquee-mcp $VERSION (universal macOS binary)…"
curl -fsSL "$BASE/marquee-mcp-$VERSION-macos.tar.gz" -o "$TMP/marquee-mcp.tar.gz"

mkdir -p "$DEST"
tar -xzf "$TMP/marquee-mcp.tar.gz" -C "$DEST"
chmod +x "$DEST/marquee-mcp"

echo
echo "Installed: $DEST/marquee-mcp"
"$DEST/marquee-mcp" --version || true
echo
echo "Wire it into Claude Code:"
echo "  claude mcp add marquee -- $DEST/marquee-mcp"
echo
echo "Or Codex — add to ~/.codex/config.toml:"
echo "  [mcp_servers.marquee]"
echo "  command = \"$DEST/marquee-mcp\""
echo
echo "Sanity check any time:  $DEST/marquee-mcp --selftest"
