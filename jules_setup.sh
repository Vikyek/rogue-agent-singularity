#!/usr/bin/env bash
set -e

# Setup environment variables
export JULES_SESSION_ID="${JULES_SESSION_ID:-17849353354405986700}"
export JULES_API_KEY="${JULES_API_KEY:-}"

echo "JULES_SESSION_ID set to $JULES_SESSION_ID"

# Update submodules
git submodule update --init --recursive

# Install TOON MCP in an isolated environment as per README
if [ ! -d ~/.local/share/toon-venv ]; then
    echo "Creating toon-venv..."
    python3 -m venv ~/.local/share/toon-venv
fi

echo "Installing toon-mcp..."
# Install in the venv
~/.local/share/toon-venv/bin/pip install -e toon-mcp/
# Also install testing dependencies
~/.local/share/toon-venv/bin/pip install pytest

echo "Setup complete!"
