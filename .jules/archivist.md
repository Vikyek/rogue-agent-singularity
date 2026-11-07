## 2026-09-25 - Shell Function Docblocks
**Learning:** Helper functions in shell scripts benefit from structured docblocks.
**Action:** Use JSDoc-style docblocks prefixed with `#` for shell script functions to improve inline clarity.

## 2026-09-24 - Document Logging Functions
**Learning:** Added JSDoc-style documentation blocks to shell script logging functions to maintain consistent inline clarity.
**Action:** Prefix docblocks in shell scripts with `#` to prevent syntax errors.

## 2026-09-23 - Shell Script Logging Function Docblocks
**Learning:** Shell script utility functions are often poorly documented. Adding JSDoc-style comments prefixed with '#' improves inline clarity and consistency without breaking syntax.
**Action:** Always add '# /** ... */' docblocks with '@param' and '@returns' for reusable shell script functions.

## 2026-09-22 - Document Setup Helpers
**Learning:** Shell scripts containing helper functions often lack structured documentation, reducing clarity for developers maintaining them.
**Action:** Always add JSDoc-style block comments prefixed with '#' (e.g., # /** ... */) to shell scripts for consistent inline clarity.

## 2026-09-21 - Document shell helper functions
**Learning:** Shell functions require docblocks just like typed languages to preserve maintainability.
**Action:** Use JSDoc-style tags prefixed with `#` for shell script function comments.

## 2026-09-20 - JSDoc-style documentation in shell scripts
**Learning:** Shell scripts often lack structured documentation for helper functions, making it harder to understand expected arguments and outputs. Using JSDoc-style tags prefixed with `#` ensures consistency with the rest of the codebase while remaining valid shell comments.
**Action:** Always add structured docblocks (`# /** ... */`) with `@param` and `@returns` for shell script functions to improve inline clarity and onboarding.

## 2024-05-15 - JSDoc syntax in Shell Scripts
**Learning:** Shell scripts typically do not support standard JSDoc block comments (which begin with `/**`), but human-readable docblocks are occasionally expected to mimic them.
**Action:** Always prefix JSDoc-style comments with `# ` in shell scripts (e.g., `# /** ... */`) to avoid syntax errors while retaining the convention requested.
