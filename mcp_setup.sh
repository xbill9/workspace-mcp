#!/bin/bash
# Simple MCP setup & verification for Antigravity (agy)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Run agy_mcp_setup.sh if credentials exist
if [ -f "$HOME/client_id.txt" ] && [ -f "$HOME/client_secret.txt" ]; then
    "$SCRIPT_DIR/agy_mcp_setup.sh"
else
    echo "Missing OAuth credentials. Run ./save_oauth.sh first."
    exit 1
fi

echo ""
echo "=========================================================="
echo "Configured MCP Servers for Antigravity (agy):"
echo "=========================================================="
agy mcp list

echo ""
echo "=========================================================="
echo "To Authenticate in agy:"
echo "1. Start agy CLI:  agy"
echo "2. Run:            /mcp"
echo "3. Select any server (gmail, drive, calendar, etc.) and choose Authenticate."
echo "   (Or in Antigravity IDE: Settings > Customizations > Installed MCP Servers -> Refresh -> Authenticate)"
echo "=========================================================="
