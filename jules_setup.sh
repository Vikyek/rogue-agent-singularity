#!/usr/bin/env bash

# Setup colors and output helpers
if [[ ! -v NO_COLOR ]]; then
    C_INFO='\033[1;34m'
    C_WARN='\033[1;33m'
    C_ERR='\033[1;31m'
    C_OK='\033[1;32m'
    C_BOLD='\033[1m'
    C_RST='\033[0m'
else
    C_INFO=''
    C_WARN=''
    C_ERR=''
    C_OK=''
    C_BOLD=''
    C_RST=''
fi

# /**
#  * Prints an informational message to stdout.
#  *
#  * @param $1 - The message to print.
#  */
info() { echo -e "${C_INFO}[INFO]${C_RST} $1"; }

# /**
#  * Prints a warning message to stderr.
#  *
#  * @param $1 - The warning message to print.
#  */
warn() { echo -e "${C_WARN}[WARN]${C_RST} $1" >&2; }

# /**
#  * Prints an error message to stderr.
#  *
#  * @param $1 - The error message to print.
#  */
error() { echo -e "${C_ERR}[ERROR]${C_RST} $1" >&2; }

# /**
#  * Prints a success message to stdout.
#  *
#  * @param $1 - The success message to print.
#  */
success() { echo -e "${C_OK}[SUCCESS]${C_RST} $1"; }

# Determine repository directory and change to it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || { return 1 2>/dev/null || exit 1; }

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    warn "Run 'source ./jules_setup.sh' to export environment variables in your current shell."
fi

info "Initializing VRAS Environment..."

if [ ! -f .vault_credentials.env ]; then
    info "Creating ${C_BOLD}.vault_credentials.env${C_RST} from ${C_BOLD}.env.example${C_RST} template..."
    cp .env.example .vault_credentials.env
    warn "Please populate ${C_BOLD}.vault_credentials.env${C_RST} with your keys."
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
    error "${C_BOLD}JULES_API_KEY${C_RST} is empty. Please populate it in ${C_BOLD}.vault_credentials.env${C_RST}"
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
            info "Applying ${C_BOLD}$patch_name${C_RST}..."

            # Apply jules_listener_injection.patch to agv-dispatcher/modules/jules-vanager submodule
            if [[ "$patch_name" == "jules_listener_injection.patch" || "$patch_name" == "jules_listener_gh_injection.patch" || "$patch_name" == jules-tui-*.patch || "$patch_name" == "jules_manager.patch" ]]; then
                if (cd "$SCRIPT_DIR/agv-dispatcher/modules/jules-vanager" && patch -p1 --reverse --dry-run < "$patch_file" >/dev/null 2>&1); then
                    info "Patch ${C_BOLD}$patch_name${C_RST} might already be applied."
                else
                    (cd "$SCRIPT_DIR/agv-dispatcher/modules/jules-vanager" && patch -p1 --forward < "$patch_file") || { error "Failed to apply ${C_BOLD}$patch_name${C_RST}"; return 1 2>/dev/null || exit 1; }
                fi
            fi

            # Apply toon_mcp_perf.patch to toon-mcp submodule
            if [[ "$patch_name" == "toon_mcp_perf.patch" || "$patch_name" == "toon_mcp_perf_iteration.patch" ]]; then
                (cd "$SCRIPT_DIR/toon-mcp" && {
                    if git apply --check --reverse "$patch_file" >/dev/null 2>&1; then
                        info "Patch ${C_BOLD}$patch_name${C_RST} might already be applied."
                    else
                        git apply "$patch_file" || { error "Failed to apply ${C_BOLD}$patch_name${C_RST}"; return 1 2>/dev/null || exit 1; }
                    fi
                })
            fi

            if [[ "$patch_name" == "paru_wrapper_awk.patch" ]]; then
                (cd "$SCRIPT_DIR/paru-wrapper" && patch -p1 --forward < "$patch_file" || info "Patch $patch_name might already be applied.")
            fi
        fi
    done
fi

VENV_DIR="${HOME}/.local/share/toon-venv"
if [ ! -d "$VENV_DIR" ]; then
    info "Creating isolated virtual environment for toon-mcp at ${C_BOLD}$VENV_DIR${C_RST}..."
    python3 -m venv "$VENV_DIR" || { error "Failed to create venv"; return 1 2>/dev/null || exit 1; }
fi

info "Installing ${C_BOLD}toon-mcp${C_RST}..."
"$VENV_DIR/bin/pip" install -e "$SCRIPT_DIR/toon-mcp/" >/dev/null || { error "Failed to install ${C_BOLD}toon-mcp${C_RST}"; return 1 2>/dev/null || exit 1; }

info "Installing testing dependencies..."
"$VENV_DIR/bin/pip" install pytest >/dev/null || { error "Failed to install pytest"; return 1 2>/dev/null || exit 1; }

success "Setup completed successfully!"
