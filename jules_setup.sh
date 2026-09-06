#!/usr/bin/env bash

# Helper functions for colored logging
log_info() { [ -z "${NO_COLOR:-}" ] && echo -e "\033[1;34m[INFO]\033[0m $1" || echo "[INFO] $1"; }
log_warn() { [ -z "${NO_COLOR:-}" ] && echo -e "\033[1;33m[WARN]\033[0m $1" >&2 || echo "[WARN] $1" >&2; }
log_err()  { [ -z "${NO_COLOR:-}" ] && echo -e "\033[1;31m✖ Error: $1\033[0m" >&2 || echo "✖ Error: $1" >&2; }
log_succ() { [ -z "${NO_COLOR:-}" ] && echo -e "\033[1;32m✔ $1\033[0m" || echo "✔ $1"; }

# Determine repository directory and change to it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || { return 1 2>/dev/null || exit 1; }

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    log_warn "Run 'source ./jules_setup.sh' to export environment variables in your current shell."
fi

echo ""
log_info "Initializing VRAS Environment..."

if [ ! -f .vault_credentials.env ]; then
    log_info "Creating .vault_credentials.env from .env.example template..."
    cp .env.example .vault_credentials.env
    log_warn "Please populate .vault_credentials.env with your keys."
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
    log_err "JULES_API_KEY is empty. Please populate it in .vault_credentials.env"
    return 1 2>/dev/null || exit 1
fi

export JULES_SESSION_ID="${JULES_SESSION_ID:-17849353354405986700}"

log_info "Initializing submodules..."
git submodule update --init --recursive >/dev/null || { log_err "Failed to initialize submodules"; return 1 2>/dev/null || exit 1; }

# Apply patches to submodules where we cannot advance upstream pointers
if [ -d "$SCRIPT_DIR/patches" ]; then
    log_info "Applying patches..."
    for patch_file in "$SCRIPT_DIR"/patches/*.patch; do
        if [ -f "$patch_file" ]; then
            patch_name=$(basename "$patch_file")
            log_info "  Applying $patch_name..."

            # Apply jules_listener_injection.patch to agv-dispatcher/modules/jules-vanager submodule
            if [[ "$patch_name" == "jules_listener_injection.patch" || "$patch_name" == jules-tui-*.patch || "$patch_name" == "jules_manager.patch" ]]; then
                (cd "$SCRIPT_DIR/agv-dispatcher/modules/jules-vanager" && patch -p1 --forward < "$patch_file" >/dev/null || log_warn "  Patch $patch_name might already be applied.")
            fi

            # Apply toon_mcp_perf.patch to toon-mcp submodule
            if [[ "$patch_name" == "toon_mcp_perf.patch" ]]; then
                (cd "$SCRIPT_DIR/toon-mcp" && {
                    if git apply --check --reverse "$patch_file" >/dev/null 2>&1; then
                        log_warn "  Patch $patch_name might already be applied."
                    else
                        git apply "$patch_file" || { log_err "Failed to apply $patch_name"; return 1 2>/dev/null || exit 1; }
                    fi
                })
            fi
        fi
    done
fi

VENV_DIR="${HOME}/.local/share/toon-venv"
if [ ! -d "$VENV_DIR" ]; then
    log_info "Creating isolated virtual environment for toon-mcp at $VENV_DIR..."
    python3 -m venv "$VENV_DIR" || { log_err "Failed to create venv"; return 1 2>/dev/null || exit 1; }
fi

log_info "Installing toon-mcp..."
"$VENV_DIR/bin/pip" install -q -e "$SCRIPT_DIR/toon-mcp/" || { log_err "Failed to install toon-mcp"; return 1 2>/dev/null || exit 1; }

log_info "Installing testing dependencies..."
"$VENV_DIR/bin/pip" install -q pytest || { log_err "Failed to install pytest"; return 1 2>/dev/null || exit 1; }

echo ""
log_succ "Setup completed successfully!"
