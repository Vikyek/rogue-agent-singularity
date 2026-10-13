## 2024-05-15 - JSDoc syntax in Shell Scripts
**Learning:** Shell scripts typically do not support standard JSDoc block comments (which begin with `/**`), but human-readable docblocks are occasionally expected to mimic them.
**Action:** Always prefix JSDoc-style comments with `# ` in shell scripts (e.g., `# /** ... */`) to avoid syntax errors while retaining the convention requested.
