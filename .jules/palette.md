## 2026-09-06 - Dynamic Curses Layouts and Vim Keybindings
**Learning:** Hardcoded coordinates in terminal UIs (like curses) can lead to visual bugs or misaligned cursors when input data lengths vary. Additionally, users expect standard terminal keybindings (like j/k for navigation) in TUI applications.
**Action:** Always calculate dynamic coordinates based on text lengths in curses applications and map standard terminal navigation keys alongside arrow keys.

## 2024-05-20 - Permanent Keyboard Shortcuts for TUI
**Learning:** In a curses-based TUI, ephemeral status messages can overwrite keyboard shortcut instructions, leaving the user without guidance.
**Action:** Always reserve a dedicated, persistent bottom row for core keyboard shortcuts so they are never obscured by temporary status updates.

## 2026-09-08 - Respecting NO_COLOR Standard in CLI
**Learning:** Terminal utilities that use ANSI escape codes for semantic formatting (like green for enabled, red for disabled) must provide a way to disable color output. This ensures accessibility for users with color vision deficiency or environments that don't support color rendering.
**Action:** Always check the `NO_COLOR` environment variable before applying ANSI escape codes in CLI tools.

## 2024-10-09 - CLI Visual Hierarchy and Strict Column Alignment
**Learning:** Relying on 'echo' with hardcoded spaces for tabular help text results in misaligned columns when command names vary in length. Additionally, repetitive state-change actions lack impact without distinct visual cues. Furthermore, scripts utilizing 'set -euo pipefail' crash when format variables (e.g., COLOR_DIM) are used before being globally initialized.
**Action:** Use 'printf' (e.g., 'printf "  %-28s %s\n" "cmd" "desc"') for rigorous CLI help text alignment. Combine standard iconography (▶, ■) with semantic colors (green, red) and bold dynamic variables to establish clear visual hierarchy for state changes. Always explicitly define all terminal formatting variables globally, checking for the absence of NO_COLOR (-z) rather than its presence, to properly enable colors and prevent unbound variable crashes.
