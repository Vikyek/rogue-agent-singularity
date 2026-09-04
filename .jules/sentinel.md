## 2025-03-09 - Remove implicit $PWD fallback in vras-submodule
**Vulnerability:** The `vras-submodule` CLI tool had an implicit fallback to `$PWD` when resolving the `VRAS_ROOT` path if explicit paths were not matched.
**Learning:** This is dangerous for global CLI tools (like those installed to `/usr/bin/`), because running them in arbitrary directories could result in executing destructive commands (like `git submodule deinit`) on unintended local Git repositories.
**Prevention:** Global CLI scripts should explicitly abort if their target data directory cannot be unambiguously resolved, instead of defaulting to the current working directory; any `VRAS_ROOT` override must be explicitly trusted to point to the intended VRAS installation.

## 2024-09-06 - Prevent command injection in subprocess commands
**Vulnerability:** A command injection vulnerability existed where `subprocess.run(["git", "branch", "-d", branch])` allowed option injection if a branch name started with a dash.
**Learning:** `git` and other CLI tools can interpret arguments that start with `-` as options rather than positional arguments.
**Prevention:** Always use `--` in subprocess calls to explicitly denote the end of options and the beginning of positional arguments (e.g. `subprocess.run(["git", "branch", "-d", "--", branch])`).

## 2025-03-08 - Path Traversal / SSRF in API Wrapper
**Vulnerability:** The `jules_manager.py` API wrapper dynamically appended `session_id` to its API URL endpoints without sanitizing the input. This allowed Path Traversal (`../../`) to be injected into the URL via the CLI argument, potentially causing SSRF against Google's API endpoints.
**Learning:** URL paths constructed dynamically from user input need sanitization.
**Prevention:** Always use `urllib.parse.quote(id, safe="")` before injecting identifiers into URL paths.
