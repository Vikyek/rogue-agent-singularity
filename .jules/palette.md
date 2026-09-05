## 2026-09-06 - Dynamic Curses Layouts and Vim Keybindings
**Learning:** Hardcoded coordinates in terminal UIs (like curses) can lead to visual bugs or misaligned cursors when input data lengths vary. Additionally, users expect standard terminal keybindings (like j/k for navigation) in TUI applications.
**Action:** Always calculate dynamic coordinates based on text lengths in curses applications and map standard terminal navigation keys alongside arrow keys.

## 2024-05-20 - Permanent Keyboard Shortcuts for TUI
**Learning:** In a curses-based TUI, ephemeral status messages can overwrite keyboard shortcut instructions, leaving the user without guidance.
**Action:** Always reserve a dedicated, persistent bottom row for core keyboard shortcuts so they are never obscured by temporary status updates.
