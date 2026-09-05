## 2025-01-20 - Submodule git commit strategy
**Learning:** When modifying files inside Git submodules, I need to commit them inside the submodule directory first, then add the submodule folder to the root repository to update the pointer.
**Action:** Follow the specific git commit order when dealing with submodules.

## 2025-01-20 - PKGBUILD redundant source items
**Learning:** When creating a PKGBUILD for a package whose release tarball encapsulates the entire source tree, listing individual source tree files (like scripts and manpages) again in the `source` array causes makepkg to look for them *outside* the extracted release context, failing the build in CI environments.
**Action:** When a project's `Makefile` handles installing local files and we fetch the source as a release archive (`.tar.gz`), do not add local files to the PKGBUILD `source` array unless they are external patches.
