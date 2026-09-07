## 2024-03-24 - [NO_COLOR support in CLI tools]
**Learning:** Hardcoded ANSI escape codes in shell scripts prevent users from disabling color outputs when needed (e.g. for CI/CD or accessibility), and `NO_COLOR` is the standard way to control this.
**Action:** When adding or maintaining CLI tools in this repository, always define color variables conditionally based on the `NO_COLOR` environment variable instead of hardcoding `\e[` or `\033[` escapes.
