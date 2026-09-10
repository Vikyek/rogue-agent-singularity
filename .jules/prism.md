## 2026-09-10 - Inverted NO_COLOR logic
**Learning:** Checking `[[ -v NO_COLOR ]]` to enable colors is an anti-pattern that breaks standard CLI UX guidelines. `NO_COLOR` should be used to disable colors when set, not enable them.
**Action:** Always use `if [[ -z "${NO_COLOR:-}" ]]; then` to enable colors by default and disable them when `NO_COLOR` is present.