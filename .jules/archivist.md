## 2026-09-20 - JSDoc-style documentation in shell scripts
**Learning:** Shell scripts often lack structured documentation for helper functions, making it harder to understand expected arguments and outputs. Using JSDoc-style tags prefixed with `#` ensures consistency with the rest of the codebase while remaining valid shell comments.
**Action:** Always add structured docblocks (`# /** ... */`) with `@param` and `@returns` for shell script functions to improve inline clarity and onboarding.
