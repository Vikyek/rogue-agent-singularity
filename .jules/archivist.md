## 2024-10-26 - Shell Script Docblocks
**Learning:** Shell functions often lack documentation, making their parameters and behaviors ambiguous.
**Action:** Apply structured JSDoc-style docblocks prefixed with `# ` to shell functions to maintain consistent inline clarity.

## 2025-02-28 - Document Shell Exit Codes
**Learning:** Shell functions like `cmd_toggle` in `vras-submodule` use plain text `@throws Exits with code 1...` rather than standard `{Type}` block definitions.
**Action:** Explicitly document all shell script exit codes using `@throws {ExitStatus} <CODE>` in JSDoc blocks to clarify error handling for consumers.
