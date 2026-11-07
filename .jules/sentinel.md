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

## 2025-03-09 - Prevent command injection in more Git commands
**Vulnerability:** A command injection vulnerability existed where `subprocess.run(["git", "rebase", "origin/main", branch])` (and `merge`, `push`) allowed option injection if a branch name started with a dash.
**Learning:** `git` and other CLI tools can interpret arguments that start with `-` as options rather than positional arguments. A previous patch only mitigated this for `git branch -d` and `git push --delete`.
**Prevention:** Always use `--` in subprocess calls to explicitly denote the end of options and the beginning of positional arguments for all git commands taking arbitrary branch names (e.g. `subprocess.run(["git", "rebase", "origin/main", "--", branch])`).

## 2026-09-27 - Prevent command injection in gh pr commands
**Vulnerability:** A command injection vulnerability existed where `subprocess.run(["gh", "pr", "view", str(number), ...])` and `subprocess.run(["gh", "pr", "merge", str(number), ...])` allowed option injection if a PR number/branch string started with a dash.
**Learning:** `gh` and other CLI tools can interpret arguments that start with `-` as options rather than positional arguments.
**Prevention:** Always use `--` in subprocess calls to explicitly denote the end of options and the beginning of positional arguments (e.g. `subprocess.run(["gh", "pr", "view", "--json", "comments,reviews", "--", str(number)])`).

## 2025-10-25 - Prevent command injection in git submodule via bash scripts
**Vulnerability:** A Git option injection vulnerability existed in vras-submodule where git submodule deinit allowed option injection if a module name started with a dash.
**Learning:** Bash scripts executing git with dynamically generated inputs are vulnerable to Git option injection. Quoting protects shell metacharacters from shell interpretation.
**Prevention:** Always insert -- before positional arguments in bash scripts executing git commands (e.g., git submodule deinit -f -- "$mod").

## 2026-09-27 - Security Fixes Inside Submodules
**Learning:** Fixes made inside submodules must be pushed to the submodule remote *before* the parent PR is opened. If this isn't done, the review system cannot verify the actual code diffs, as the parent PR only contains a pointer bump.
**Constraint:** The sandbox environment cannot authenticate to submodule remotes over HTTPS, meaning any submodule push requires manual intervention from the user to push locally.

## 2026-10-04 - Validate externally-derived git refs before subprocess calls
**Vulnerability:** External branches and PR numbers fetched via `gh pr list --json headRefName` were fed directly into subprocess arguments. `git push` and other commands do not strictly treat `--` as an end-of-options marker for refspecs.
**Learning:** Relying on `--` is insufficient for `git push`. A malicious refspec like `--help` or `../evil` could bypass it.
**Prevention:** Apply strict regex-based allowlist validation (e.g., `^[A-Za-z0-9._/-]+$`, rejecting `..` and leading `-`) on all dynamically fetched strings *before* inserting them into shell commands, instead of just trying to safely format them.

## 2025-03-09 - Prevent unbound variable crash in NO_COLOR environments
**Vulnerability:** A shell script setting `set -euo pipefail` would crash if a formatting variable (like `COLOR_DIM`) was used in an output string but not initialized in all execution branches.
**Learning:** Defensive bash scripting requires all variables to be explicitly initialized, especially when strict mode (`-u`) is enforced.
**Prevention:** Always initialize all format/color variables to empty strings when disabling colors (e.g., `NO_COLOR`), or use default parameter expansion (`${COLOR_DIM:-}`).

## 2025-10-24 - Prevent command injection in git submodule commands
**Vulnerability:** A command injection vulnerability existed where `git submodule status "$mod"`, `git submodule update --init --recursive "$mod"`, and `git submodule deinit -f "$mod"` allowed option injection if a module name started with a dash.
**Learning:** Bash scripts calling `git` commands can interpret arguments that start with `-` as options rather than positional arguments.
**Prevention:** Always use `--` in git commands to explicitly denote the end of options and the beginning of positional arguments (e.g., `git submodule status -- "$mod"`).

## 2025-03-09 - Prevent command injection in git submodule commands within shell scripts
**Vulnerability:** The `vras-submodule` shell script executed `git submodule status "$mod"`, `git submodule update --init --recursive "$mod"`, and `git submodule deinit -f "$mod"` without using `--` to signify the end of options. This allows command option injection if a module name is substituted that begins with a dash.
**Learning:** Shell scripts orchestrating Git commands must also defend against option injection, just like Python subprocess calls.
**Prevention:** Always use `--` in shell scripts before substituting variables into `git` commands that accept arbitrary file paths or names (e.g. `git submodule status -- "$mod"`).

## 2025-03-09 - Prevent option injection in shell script git commands
**Vulnerability:** A command injection vulnerability existed where `git submodule status "$mod"` (and `update`, `deinit`) in bash scripts allowed option injection if a module name started with a dash.
**Learning:** Just like Python's `subprocess`, shell scripts calling `git` (or other CLI tools) can interpret variables starting with `-` as options rather than positional arguments.
**Prevention:** Always use `--` in bash script CLI calls to explicitly denote the end of options before passing user-controlled or dynamic arguments (e.g., `git submodule status -- "$mod"`).

## 2025-03-09 - Prevent option injection in bash script git commands
**Vulnerability:** A command injection vulnerability existed in vras-submodule where `git submodule status/update/deinit "$mod"` allowed option injection if a submodule name started with a dash.
**Learning:** Like Python's subprocess, bash scripts calling CLI tools can interpret variables that start with `-` as options.
**Prevention:** Always use `--` in bash commands to explicitly denote the end of options before passing variables (e.g. `git submodule status -- "$mod"`).

## 2025-03-09 - Prevent option injection in vras-submodule
**Vulnerability:** A command injection vulnerability existed where `vras-submodule` passed user-supplied variables directly to `git submodule` commands (like `status`, `update`, `deinit`). This allowed option injection if a module name started with a dash.
**Learning:** Shell scripts taking user input and passing it to command-line tools can lead to option injection vulnerabilities.
**Prevention:** Always use `--` in shell script calls to explicitly denote the end of options and the beginning of positional arguments for external commands taking arbitrary names (e.g. `git submodule status -- "$mod"`).

## 2026-09-14 - Fix git command option injection
**Vulnerability:** Shell scripts executed `git submodule` commands without the `--` delimiter, allowing option injection vulnerabilities if users provide input like `--rebase`.
**Learning:** Whenever executing Git (or other CLI) commands dynamically in a shell script, user-supplied identifiers should be separated from options.
**Prevention:** Always use the `--` delimiter before user-controlled arguments when executing commands in shell scripts.

## 2025-03-09 - Prevent option injection in bash git submodule commands
**Vulnerability:** An option injection vulnerability existed in `vras-submodule` where `git submodule update` and `deinit` could be passed an arbitrary submodule name. If the module name started with a dash (e.g., `--checkout`), git interpreted it as a command option instead of a submodule path.
**Learning:** Bash variables passed directly to commands like git can be evaluated as options if they start with a hyphen, which is a common command injection vector.
**Prevention:** Always use `--` to delimit options from user-controlled arguments in shell scripts (e.g., `git submodule update --init --recursive -- "$mod"`).

## 2026-09-12 - Prevent command injection in jules_listener git push and branch
**Vulnerability:** A command injection vulnerability existed where `subprocess.run(["git", "branch", "-d", branch])` and `git push --delete` allowed option injection if a branch name started with a dash.
**Learning:** `git` and other CLI tools can interpret arguments that start with `-` as options rather than positional arguments.
**Prevention:** Always use `--` in subprocess calls to explicitly denote the end of options and the beginning of positional arguments (e.g. `subprocess.run(["git", "branch", "-d", "--", branch])`).
