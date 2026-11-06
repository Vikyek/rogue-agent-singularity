## 2025-10-24 - Batch git submodule status checks in bash loops
**Learning:** `vras-submodule` loops over submodules, calling `git submodule status $mod` multiple times inside the loop. `git submodule status` without arguments outputs the status for all submodules. Calling it once and parsing the output is much faster than spawning multiple `git` processes inside a loop.
**Action:** Use a single `git submodule status` call and parse the output rather than executing git commands inside a loop.

## 2025-01-20 - Submodule git commit strategy
**Learning:** When modifying files inside Git submodules, I need to commit them inside the submodule directory first, then add the submodule folder to the root repository to update the pointer.
**Action:** Follow the specific git commit order when dealing with submodules.

## 2025-01-20 - PKGBUILD redundant source items
**Learning:** When creating a PKGBUILD for a package whose release tarball encapsulates the entire source tree, listing individual source tree files (like scripts and manpages) again in the `source` array causes makepkg to look for them *outside* the extracted release context, failing the build in CI environments.
**Action:** When a project's `Makefile` handles installing local files and we fetch the source as a release archive (`.tar.gz`), do not add local files to the PKGBUILD `source` array unless they are external patches.

## 2025-01-20 - AUR Package Submodule Fetching
**Learning:** In an AUR `PKGBUILD`, running `git submodule update` in the `package()` function or through `make install` fails in isolated build environments (like makepkg or GitHub Actions) because it attempts to fetch from the network. When an Arch package relies on submodules, the correct standard is to declare the submodules as `git+https` sources in the `source` array, explicitly inject their local `$srcdir` paths using `git config submodule...` in the `prepare()` function, and then allow the build to proceed cleanly without network requests.
**Action:** When a repository relies on Git submodules and requires an AUR package, structure the `PKGBUILD` to fetch all submodules in the `source` array using the standard Arch Linux submodule handling pattern, and prevent `make install` from making network calls by using `GIT_CEILING_DIRECTORIES`.

## 2026-09-04 - [Optimize Array Comprehension for TOON Object Schemas]
**Learning:** Generating sets out of Python dictionary keys and doing set unions/intersections on them is extremely inefficient for checking if a list of dictionaries all have identical schema keys. Doing `if item.keys() == first_item.keys()` is dramatically faster because Python dictionaries natively optimize `dict_keys` comparisons and it doesn't instantiate any `set` or `tuple` copies.
**Action:** When validating uniformity of dictionary schemas in large arrays, use the `dict_keys` equality view (`item.keys() == first_keys`) rather than doing expensive conversions to `set` and `tuple` for every item.
## $(date +%Y-%m-%d) - Optimize schema consistency pattern detection
**Learning:** Checking dictionary schema consistency using set operations (e.g., `set(item.keys())`, `set.union`, `set.intersection`) is slow and allocates significant memory for homogeneous arrays of dictionaries, which are common in JSON APIs.
**Action:** Always implement a fast path using native `dict_keys` equality (`item.keys() == first_item.keys()`). This evaluates set-like equality in C (order-agnostic in Python 3), but still allocates the `valid_items` list for each array, so it does not provide O(1) space. It remains a fast O(N) time optimization before falling back to expensive `set` operations.
## 2026-09-27 - Optimize Array Comprehension and Recursion Overhead
**Learning:** Generating sets out of Python dictionary keys and doing recursive python tree traversals when calculating dictionary frequencies is extremely slow and causes excessive allocations. Dictionaries natively evaluate key equality very fast with `item.keys() == first_keys` and bulk add counts to collections using `Counter.update()` without creating new memory or nested function frames.
**Action:** When validating dictionary arrays or counting key frequencies in deep structures, always use `dict_keys` comparison fast paths, and `Counter.update()` coupled with iterative stack traversals rather than mapping to sets or using recursion.
## 2026-10-10 - Parent-repo reviewers are blind to submodule diffs
**Learning:** Committing inside the submodule still yields only a gitlink bump; GitHub cannot diff mode-160000 entries, and the sandbox lacks push creds for submodule remotes, so Bolt tasks there always stall at review.
**Action:** Any task touching a submodule must (a) emit a format-patch artifact in the parent PR and (b) flag itself as a two-PR job at PLAN time, before edits.
## 2026-09-28 - Optimize Dictionary Key Fast Paths
**Learning:** Generating sets out of Python dictionary keys and doing recursive python tree traversals is extremely slow. Dictionaries natively evaluate key equality very fast with `item.keys() == first_keys` and bulk add counts using `Counter.update()` without creating new memory or nested frames.
**Action:** When validating dictionary arrays or counting key frequencies in deep structures, always use `dict_keys` comparison fast paths, and `Counter.update()` coupled with iterative stack traversals rather than mapping to sets or using recursion.
## 2026-10-06 - Batch bash operations to avoid subshells in loops
**Learning:** The implementation scans the pre-fetched status output once per module using a native bash `while read` loop. This avoids spawning external `grep` and `awk` processes inside the loop, but does not provide O(1) lookups.
**Action:** Use a native bash `while read` loop and string manipulation to scan the status output for each module, rather than creating subshells and piping text to external utilities like `grep` or `awk`.
## 2026-10-06 - Optimize Dictionary Array Schema Validations
**Learning:** Checking dictionary schema consistency using set operations (e.g., `set(item.keys())`, `set.union`, `set.intersection`) is slow and allocates significant memory for homogeneous arrays of dictionaries.
**Action:** Always implement a fast path using native `dict_keys` equality (`item.keys() == first_item.keys()`). This evaluates set-like equality in C, drastically improving runtime for the common case of identical schemas.
## 2026-10-10 - Submodule changes are invisible to the parent-repo reviewer
**Learning:** A gitlink bump carries no diff, so reviewers reject perf work done inside submodules; the sandbox also lacks push creds for submodule remotes.
**Action:** Always emit .jules/patches/<submodule>-<branch>.patch and embed the diff in the PR body; flag submodule tasks as needing a companion PR up front.
## 2025-02-18 - Avoid generator overhead in critical path loops
**Learning:** Even when using fast paths like `dict_keys` equality, wrapping the check in an `all()` generator expression introduces overhead compared to an explicit for loop with a break statement.
**Action:** In heavily utilized compression paths, prefer explicit for loops with early exit over Python generator expressions.
