#!/bin/bash
# Register the Google Workspace MCP servers with Codex CLI (~/.codex/config.toml).
# Reads the OAuth client from ~/client_id.txt and ~/client_secret.txt (see save_oauth.sh).

if [ ! -f "$HOME/client_id.txt" ] || [ ! -f "$HOME/client_secret.txt" ]; then
    echo "Missing OAuth client. Run ./save_oauth.sh first."
    exit 1
fi

CLIENT_ID=$(tr -d '[:space:]' < "$HOME/client_id.txt")
CLIENT_SECRET=$(tr -d '[:space:]' < "$HOME/client_secret.txt")

CODEX_CONFIG="$HOME/.codex/config.toml"
mkdir -p "$(dirname "$CODEX_CONFIG")"
touch "$CODEX_CONFIG"

add() {
    local name="$1"
    local url="$2"
    codex mcp remove "$name" > /dev/null 2>&1
    cat <<EOF >> "$CODEX_CONFIG"

[mcp_servers.$name]
url = "$url"

[mcp_servers.$name.oauth]
client_id = "$CLIENT_ID"
client_secret = "$CLIENT_SECRET"
callback_url = "http://127.0.0.1/callback"
EOF
    echo "Added global Codex MCP server '$name'."
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
echo "In Codex CLI, run 'codex mcp login <server>' (or '/mcp' inside Codex) to authenticate each service in the browser."
