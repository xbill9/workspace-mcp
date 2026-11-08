# Workspace MCP

This workspace provides a set of scripts to initialize and manage a Google Cloud environment for use with Model Context Protocol (MCP) servers

## Scripts

### `init.sh`
Initializes the Google Cloud environment.
- Sets the project ID.
- Enables necessary Google Cloud APIs (Gmail, Drive, Calendar, Chat, People, Docs, Sheets, Slides).
- Enables the corresponding MCP APIs.
- Creates a `.env` file with default configurations.
- Configures Application Default Credentials (ADC).

### `set_env.sh`
Refreshes the environment configuration.
- Updates the `.env` file based on the current `gcloud` project.
- Checks authentication status.

### `set_adc.sh`
Ensures that both `gcloud` and Application Default Credentials (ADC) are authenticated. This script should be sourced:
```bash
source ./set_adc.sh
```

### `save_oauth.sh`
A helper script to prompt for and store Google Cloud project credentials (Project ID, Client ID, Client Secret) in your home directory for reuse.

### `mcp_setup.sh`
Provides instructions for setting up MCP on Gemini CLI.
- Lists the necessary `/mcp auth` commands for Calendar, Chat, Drive, Gmail, People, Docs, Sheets, and Slides.
- Explains how to verify the connection using `/mcp list`.

### `agy_mcp_setup.sh`
Registers the Gmail, Drive, Docs, Sheets, Slides, Calendar, Chat, and People MCP servers in Antigravity (`~/.gemini/config/mcp_config.json`), using the OAuth client saved by `save_oauth.sh`. Then run `/mcp` in Antigravity CLI (`agy`) or use **Settings > Customizations > Installed MCP Servers** in Antigravity IDE/GUI to authenticate each one.

### `claude_mcp_setup.sh`
Registers the Gmail, Calendar, People, Chat, Docs, Sheets and Slides MCP servers with Claude Code, using the OAuth client saved by `save_oauth.sh`. Then run `/mcp` inside Claude Code to authenticate each one.

### `codex_mcp_setup.sh`
Registers the Gmail, Drive, Calendar, People, Chat, Docs, Sheets, and Slides MCP servers with Codex CLI (`~/.codex/config.toml`), using the OAuth client saved by `save_oauth.sh`. Then run `codex mcp login <server> --scopes <scopes>` or `/mcp` inside Codex to authenticate each one.

## Prerequisites
- [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)

## Getting Started
1. Run `./init.sh` and follow the prompts to set your Project ID.
2. Source the ADC script: `source ./set_adc.sh`.
3. Verify your environment: `./set_env.sh`.
