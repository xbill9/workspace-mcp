#!/bin/bash
# Register the Google Workspace MCP servers with Claude Code (user scope, all projects on this PC).
# Reads the OAuth client from ~/client_id.txt and ~/client_secret.txt (see save_oauth.sh).

if [ ! -f "$HOME/client_id.txt" ] || [ ! -f "$HOME/client_secret.txt" ]; then
    echo "Missing OAuth client. Run ./save_oauth.sh first."
    exit 1
fi

CLIENT_ID=$(tr -d '[:space:]' < "$HOME/client_id.txt")
export MCP_CLIENT_SECRET=$(tr -d '[:space:]' < "$HOME/client_secret.txt")

add() {
    claude mcp remove "$1" -s local > /dev/null 2>&1
    claude mcp remove "$1" -s user > /dev/null 2>&1
    claude mcp add -s user --transport http --client-id "$CLIENT_ID" --client-secret "$1" "$2" < /dev/null
}

add gmail    https://gmailmcp.googleapis.com/mcp/v1
add drive    https://drivemcp.googleapis.com/mcp/v1
add calendar https://calendarmcp.googleapis.com/mcp/v1
add people   https://people.googleapis.com/mcp/v1
add chat     https://chatmcp.googleapis.com/mcp/v1
add docs     https://docsmcp.googleapis.com/mcp/v1
add sheets   https://sheetsmcp.googleapis.com/mcp/v1
add slides   https://slidesmcp.googleapis.com/mcp/v1

echo ""
echo "In Claude Code, run /mcp and authenticate gmail, drive, calendar, people, chat, docs, sheets and slides in the browser."
