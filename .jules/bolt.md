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

## 2026-09-12 - Optimize JSON traversal loops
**Learning:** Recursively traversing deep or large JSON dictionaries and arrays to collect key frequencies is slow due to Python function call overhead and manual element iteration.
**Action:** For simple aggregation tasks like `Counter` frequencies, always prefer an iterative stack-based traversal and use bulk native operations like `Counter.update(dict.keys())` to process dictionary keys in C, yielding significant performance gains.
