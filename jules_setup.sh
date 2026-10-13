#!/usr/bin/env bash

# Setup colors and output helpers
if [[ -v NO_COLOR ]]; then
    C_INFO='\033[1;34m'
    C_WARN='\033[1;33m'
    C_ERR='\033[1;31m'
    C_OK='\033[1;32m'
    C_RST='\033[0m'
else
    C_INFO=''
    C_WARN=''
    C_ERR=''
    C_OK=''
    C_RST=''
fi

info() { echo -e "${C_INFO}[INFO]${C_RST} $1"; }
warn() { echo -e "${C_WARN}[WARN]${C_RST} $1" >&2; }
error() { echo -e "${C_ERR}[ERROR]${C_RST} $1" >&2; }
success() { echo -e "${C_OK}[SUCCESS]${C_RST} $1"; }

# Determine repository directory and change to it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || { return 1 2>/dev/null || exit 1; }

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    warn "Run 'source ./jules_setup.sh' to export environment variables in your current shell."
fi

info "Initializing VRAS Environment..."

if [ ! -f .vault_credentials.env ]; then
    info "Creating .vault_credentials.env from .env.example template..."
    cp .env.example .vault_credentials.env
    warn "Please populate .vault_credentials.env with your keys."
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
    error "JULES_API_KEY is empty. Please populate it in .vault_credentials.env"
    return 1 2>/dev/null || exit 1
fi

export JULES_SESSION_ID="${JULES_SESSION_ID:-17849353354405986700}"

info "Initializing submodules..."
git submodule update --init --recursive || { error "Failed to initialize submodules"; return 1 2>/dev/null || exit 1; }

# Apply patches to submodules where we cannot advance upstream pointers
if [ -d "$SCRIPT_DIR/patches" ]; then
    info "Applying patches..."
    for patch_file in "$SCRIPT_DIR"/patches/*.patch; do
        if [ -f "$patch_file" ]; then
            patch_name=$(basename "$patch_file")
            info "Applying $patch_name..."

            # Apply jules_listener_injection.patch to agv-dispatcher/modules/jules-vanager submodule
            if [[ "$patch_name" == "jules_listener_injection.patch" || "$patch_name" == jules-tui-*.patch || "$patch_name" == "jules_manager.patch" ]]; then
                (cd "$SCRIPT_DIR/agv-dispatcher/modules/jules-vanager" && patch -p1 --forward < "$patch_file" || info "Patch $patch_name might already be applied.")
            fi

            if [[ "$patch_name" == "integrator-update-paru-awk-parsing.patch" ]]; then
                (cd "$SCRIPT_DIR/paru-wrapper" && patch -p1 --forward < "$patch_file" || info "Patch $patch_name might already be applied.")
            fi

            # Apply toon_mcp_perf.patch to toon-mcp submodule
            if [[ "$patch_name" == "toon_mcp_perf.patch" ]]; then
                (cd "$SCRIPT_DIR/toon-mcp" && {
                    if git apply --check --reverse "$patch_file" >/dev/null 2>&1; then
                        info "Patch $patch_name might already be applied."
                    else
                        git apply "$patch_file" || { error "Failed to apply $patch_name"; return 1 2>/dev/null || exit 1; }
                    fi
                })
            fi
        fi
    done
fi

VENV_DIR="${HOME}/.local/share/toon-venv"
if [ ! -d "$VENV_DIR" ]; then
    info "Creating isolated virtual environment for toon-mcp at $VENV_DIR..."
    python3 -m venv "$VENV_DIR" || { error "Failed to create venv"; return 1 2>/dev/null || exit 1; }
fi

info "Installing toon-mcp..."
"$VENV_DIR/bin/pip" install -e "$SCRIPT_DIR/toon-mcp/" >/dev/null || { error "Failed to install toon-mcp"; return 1 2>/dev/null || exit 1; }

info "Installing testing dependencies..."
"$VENV_DIR/bin/pip" install pytest >/dev/null || { error "Failed to install pytest"; return 1 2>/dev/null || exit 1; }

success "Setup completed successfully!"
