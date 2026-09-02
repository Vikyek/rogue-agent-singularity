#!/usr/bin/env bash

# Determine repository directory and change to it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || return 1 2>/dev/null

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "WARNING: Run 'source ./jules_setup.sh' to export environment variables in your current shell."
fi

echo "Initializing VRAS Environment..."

if [ ! -f .vault_credentials.env ]; then
    echo "Creating .vault_credentials.env from .env.example template..."
    cp .env.example .vault_credentials.env
    echo "Please populate .vault_credentials.env with your keys."
fi

if [ -f .vault_credentials.env ]; then
    set -a
    source .vault_credentials.env
    set +a
fi

if [ -z "${JULES_API_KEY}" ]; then
    echo "ERROR: JULES_API_KEY is empty. Please populate it in .vault_credentials.env"
    if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
        return 1 2>/dev/null
    else
        kill -TERM $$
    fi
fi

export JULES_SESSION_ID="${JULES_SESSION_ID:-17849353354405986700}"

echo "Initializing submodules..."
git submodule update --init --recursive || { echo "Failed to initialize submodules"; if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then return 1 2>/dev/null; else kill -TERM $$; fi; }

VENV_DIR="${HOME}/.local/share/toon-venv"
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating isolated virtual environment for toon-mcp at $VENV_DIR..."
    python3 -m venv "$VENV_DIR" || { echo "Failed to create venv"; if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then return 1 2>/dev/null; else kill -TERM $$; fi; }
fi

echo "Installing toon-mcp..."
"$VENV_DIR/bin/pip" install -e "$SCRIPT_DIR/toon-mcp/" || { echo "Failed to install toon-mcp"; if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then return 1 2>/dev/null; else kill -TERM $$; fi; }

echo "Installing testing dependencies..."
"$VENV_DIR/bin/pip" install pytest || { echo "Failed to install pytest"; if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then return 1 2>/dev/null; else kill -TERM $$; fi; }

echo "Setup completed successfully!"
