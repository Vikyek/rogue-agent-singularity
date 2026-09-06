#!/usr/bin/env bash

# Determine repository directory and change to it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || { return 1 2>/dev/null || exit 1; }

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
    # Parse env file without altering shell configuration flags
    while IFS= read -r line || [ -n "$line" ]; do
        # Ignore comments and empty lines
        if [[ ! "$line" =~ ^# ]] && [[ -n "$line" ]]; then
            export "$line"
        fi
    done < .vault_credentials.env
fi

if [ -z "${JULES_API_KEY}" ]; then
    echo "ERROR: JULES_API_KEY is empty. Please populate it in .vault_credentials.env"
    return 1 2>/dev/null || exit 1
fi

export JULES_SESSION_ID="${JULES_SESSION_ID:-17849353354405986700}"

echo "Initializing submodules..."
git submodule update --init --recursive || { echo "Failed to initialize submodules"; return 1 2>/dev/null || exit 1; }

# Apply patches to submodules where we cannot advance upstream pointers
if [ -d "$SCRIPT_DIR/patches" ]; then
    echo "Applying patches..."
    for patch_file in "$SCRIPT_DIR"/patches/*.patch; do
        if [ -f "$patch_file" ]; then
            patch_name=$(basename "$patch_file")
            echo "Applying $patch_name..."

            # Apply toon_mcp_perf.patch to toon-mcp submodule
            if [[ "$patch_name" == "toon_mcp_perf.patch" ]]; then
                (cd "$SCRIPT_DIR/toon-mcp" && git apply "$patch_file" 2>/dev/null || echo "Patch $patch_name might already be applied.")
            fi
        fi
    done
fi

VENV_DIR="${HOME}/.local/share/toon-venv"
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating isolated virtual environment for toon-mcp at $VENV_DIR..."
    python3 -m venv "$VENV_DIR" || { echo "Failed to create venv"; return 1 2>/dev/null || exit 1; }
fi

echo "Installing toon-mcp..."
"$VENV_DIR/bin/pip" install -e "$SCRIPT_DIR/toon-mcp/" || { echo "Failed to install toon-mcp"; return 1 2>/dev/null || exit 1; }

echo "Installing testing dependencies..."
"$VENV_DIR/bin/pip" install pytest || { echo "Failed to install pytest"; return 1 2>/dev/null || exit 1; }

echo "Setup completed successfully!"
