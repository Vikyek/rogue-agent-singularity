## 2026-09-12 - Fix parsing drift for pacman/paru output
**Learning:** The awk regex for parsing pacman dependencies was too brittle and prematurely stopped parsing dependencies when encountering wrapped lines or varying padding.
**Action:** Use a robust regex `/^[A-Z][a-zA-Z -]*[[:space:]]*:/` to correctly detect section headers preventing truncation.
