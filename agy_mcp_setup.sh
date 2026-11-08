#!/bin/bash
# Register the Google Workspace MCP servers in Antigravity (~/.gemini/config/mcp_config.json).
# Reads the OAuth client from ~/client_id.txt and ~/client_secret.txt (see save_oauth.sh).

if [ ! -f "$HOME/client_id.txt" ] || [ ! -f "$HOME/client_secret.txt" ]; then
    echo "Missing OAuth client. Run ./save_oauth.sh first."
    exit 1
fi

CLIENT_ID=$(tr -d '[:space:]' < "$HOME/client_id.txt")
CLIENT_SECRET=$(tr -d '[:space:]' < "$HOME/client_secret.txt")

MCP_CONFIG="$HOME/.gemini/config/mcp_config.json"
mkdir -p "$(dirname "$MCP_CONFIG")"

if [ ! -f "$MCP_CONFIG" ]; then
    echo '{"mcpServers":{}}' > "$MCP_CONFIG"
fi

TMP_FILE=$(mktemp)
jq --arg cid "$CLIENT_ID" --arg csec "$CLIENT_SECRET" '
  .mcpServers = (.mcpServers // {}) |
  .mcpServers.gmail = {
    "serverUrl": "https://gmailmcp.googleapis.com/mcp/v1",
    "oauth": { "clientId": $cid, "clientSecret": $csec }
  } |
  .mcpServers.drive = {
    "serverUrl": "https://drivemcp.googleapis.com/mcp/v1",
    "oauth": { "clientId": $cid, "clientSecret": $csec }
  } |
  .mcpServers.docs = {
    "serverUrl": "https://docsmcp.googleapis.com/mcp/v1",
    "oauth": { "clientId": $cid, "clientSecret": $csec }
  } |
  .mcpServers.sheets = {
    "serverUrl": "https://sheetsmcp.googleapis.com/mcp/v1",
    "oauth": { "clientId": $cid, "clientSecret": $csec }
  } |
  .mcpServers.slides = {
    "serverUrl": "https://slidesmcp.googleapis.com/mcp/v1",
    "oauth": { "clientId": $cid, "clientSecret": $csec }
  } |
  .mcpServers.calendar = {
    "serverUrl": "https://calendarmcp.googleapis.com/mcp/v1",
    "oauth": { "clientId": $cid, "clientSecret": $csec }
  } |
  .mcpServers.chat = {
    "serverUrl": "https://chatmcp.googleapis.com/mcp/v1",
    "oauth": { "clientId": $cid, "clientSecret": $csec }
  } |
  .mcpServers.people = {
    "serverUrl": "https://people.googleapis.com/mcp/v1",
    "oauth": { "clientId": $cid, "clientSecret": $csec }
  }
' "$MCP_CONFIG" > "$TMP_FILE" && mv "$TMP_FILE" "$MCP_CONFIG"

echo "Added gmail, drive, docs, sheets, slides, calendar, chat, and people to $MCP_CONFIG"
echo ""
echo "In Antigravity CLI (agy), run /mcp and select Authenticate for each server."
echo "In Antigravity IDE/GUI, go to Settings > Customizations > Installed MCP Servers, click Refresh, and Authenticate each server."
