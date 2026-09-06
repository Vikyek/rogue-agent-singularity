## 2025-03-09 - Remove implicit $PWD fallback in vras-submodule
**Vulnerability:** The `vras-submodule` CLI tool had an implicit fallback to `$PWD` when resolving the `VRAS_ROOT` path if explicit paths were not matched.
**Learning:** This is dangerous for global CLI tools (like those installed to `/usr/bin/`), because running them in arbitrary directories could result in executing destructive commands (like `git submodule deinit`) on unintended local Git repositories.
**Prevention:** Global CLI scripts should explicitly abort if their target data directory cannot be unambiguously resolved, instead of defaulting to the current working directory; any `VRAS_ROOT` override must be explicitly trusted to point to the intended VRAS installation.
