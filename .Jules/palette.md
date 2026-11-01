## 2024-05-24 - Add explicit interaction & cancel hints in TUI
**Learning:** TUI interfaces need explicit action indicators (like how to cancel a prompt or how to interact with an item) as discoverability is lower than web UI.
**Action:** Always include explicitly how to use inputs when building TUI flows.

## 2026-11-01 - Nested submodules break agent PRs
**Learning:** Bumping a submodule pointer to a local-only commit produces an uncloneable tree; code review flags it, but only after work is done.
**Action:** Detect nested remotes up front. If no push access, ship changes as a patch + apply script and leave all gitlinks untouched.
