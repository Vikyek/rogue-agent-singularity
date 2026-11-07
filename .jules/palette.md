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

## 2024-05-23 - Submodule Status Dimming
**Learning:** Long commit hashes and auxiliary information (like "(uninitialized)") in TUI lists create visual noise.
**Action:** Truncate hashes (e.g. to 7 chars) and apply dim coloring (\e[2m) to auxiliary text to maintain visual hierarchy.

## 2024-05-20 - Truncate and Dim Long Hashes in Terminals
**Learning:** Printing long 40-character commit hashes in terminal output creates visual noise and disrupts visual hierarchy.
**Action:** Truncate long metadata strings (like commit hashes to 7 chars) and apply a dim terminal color (`\e[2m`) to reduce cognitive load and visual noise while preserving functional value.

## 2026-09-20 - Submodule status list formatting
**Learning:** Long 40-character commit hashes in terminal lists create excessive visual noise, hurting scannability and UX.
**Action:** When printing long metadata strings (like commit hashes) in terminal lists, truncate them (e.g., to 7 characters) and use dim ANSI coloring (\e[2m) to maintain visual hierarchy while respecting NO_COLOR.

## 2024-05-21 - Dimming and Truncating Metadata in CLI Lists
**Learning:** When printing long metadata strings (like 40-character commit hashes) in terminal lists, they create excessive visual noise that distracts from the core information.
**Action:** Truncate long metadata strings (e.g., to 7 characters) and use dim ANSI coloring (\e[2m) to reduce visual noise and maintain visual hierarchy, while respecting NO_COLOR.

## 2025-05-18 - Truncate Long Hashes for Visual Hierarchy
**Learning:** Terminal outputs displaying full 40-character commit hashes next to module statuses create unnecessary visual noise and distract from the actual status. Truncating the hashes and dimming them reduces visual noise and improves the visual hierarchy.
**Action:** When printing long metadata strings (like commit hashes) in terminal lists, truncate them (e.g., to 7 characters) and use dim ANSI coloring (\e[2m) to reduce visual noise.

## 2024-05-21 - Visual Hierarchy in Terminal Lists
**Learning:** When printing long metadata strings (like 40-character commit hashes) in terminal lists, they can create visual noise that distracts from the primary information.
**Action:** Truncate long metadata strings (e.g., to 7 characters for git hashes) and use dim ANSI coloring (\e[2m) to reduce visual noise and maintain visual hierarchy, making the list easier to scan.

## 2024-05-24 - Dynamic Coordinates and Vim Keys in Curses
**Learning:** Curses-based applications require dynamic text length calculations (using functions like `len()`) for coordinate inputs, as hardcoded values will cause cursor misalignments and overlapping text when window sizes or dynamic text changes. Standard arrow keys also fall short of expectations for power users needing Vim keybindings (`j` and `k`) for list navigation.
**Action:** When building or modifying curses-based TUI applications, calculate dynamic string lengths for input X-coordinates and always map standard Vim keybindings (`j/k`) alongside arrow keys for intuitive navigation.

## 2024-05-21 - Dimming and Truncating Commit Hashes
**Learning:** When printing long metadata strings (like 40-character commit hashes) in terminal lists, they can cause excessive visual noise.
**Action:** Truncate them (e.g., to 7 characters) and use dim ANSI coloring (\e[2m) to reduce visual noise and maintain visual hierarchy.
