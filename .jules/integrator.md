## 2026-09-24 - Integrator: fix paru awk parsing drift
**Learning:** Parsing `paru` and `pacman` outputs for dependencies requires a strict regex for section headers (`/^[A-Z][a-zA-Z -]*[[:space:]]*:/`) to prevent bugs when parsing multi-line outputs like `Optional Deps :`.
**Action:** Apply strict format matching for headers when using awk for output processing.
