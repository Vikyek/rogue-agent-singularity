## 2025-01-20 - Submodule git commit strategy
**Learning:** When modifying files inside Git submodules, I need to commit them inside the submodule directory first, then add the submodule folder to the root repository to update the pointer.
**Action:** Follow the specific git commit order when dealing with submodules.

## 2025-01-20 - PKGBUILD redundant source items
**Learning:** When creating a PKGBUILD for a package whose release tarball encapsulates the entire source tree, listing individual source tree files (like scripts and manpages) again in the `source` array causes makepkg to look for them *outside* the extracted release context, failing the build in CI environments.
**Action:** When a project's `Makefile` handles installing local files and we fetch the source as a release archive (`.tar.gz`), do not add local files to the PKGBUILD `source` array unless they are external patches.

## 2025-01-20 - AUR Package Submodule Fetching
**Learning:** In an AUR `PKGBUILD`, running `git submodule update` in the `package()` function or through `make install` fails in isolated build environments (like makepkg or GitHub Actions) because it attempts to fetch from the network. When an Arch package relies on submodules, the correct standard is to declare the submodules as `git+https` sources in the `source` array, explicitly inject their local `$srcdir` paths using `git config submodule...` in the `prepare()` function, and then allow the build to proceed cleanly without network requests.
**Action:** When a repository relies on Git submodules and requires an AUR package, structure the `PKGBUILD` to fetch all submodules in the `source` array using the standard Arch Linux submodule handling pattern, and prevent `make install` from making network calls by using `GIT_CEILING_DIRECTORIES`.
