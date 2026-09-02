#!/usr/bin/env bash
set -e

# setup.sh - VRAS Project Initialization Script

echo "Initializing VRAS Environment..."

# 1. Ensure environment variables template exists
if [ ! -f .vault_credentials.env ]; then
    echo "Creating .vault_credentials.env from .env.example template..."
    cp .env.example .vault_credentials.env
    echo "Please populate .vault_credentials.env with your keys."
fi

# Export from env file if present
if [ -f .vault_credentials.env ]; then
    set -a
    source .vault_credentials.env
    set +a
fi

# 2. Initialize Git submodules
echo "Initializing submodules..."
git submodule update --init --recursive

# 3. Setup Virtual Environment for toon-mcp
VENV_DIR="${HOME}/.local/share/toon-venv"
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating isolated virtual environment for toon-mcp at $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
fi

echo "Installing toon-mcp..."
"$VENV_DIR/bin/pip" install -e toon-mcp/

# 4. Optional Testing Dependencies
echo "Installing testing dependencies..."
"$VENV_DIR/bin/pip" install pytest

echo "Setup completed successfully!"
