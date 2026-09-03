## 2025-10-24 - Batch git submodule status checks in bash loops
**Learning:** `vras-submodule` loops over submodules, calling `git submodule status $mod` multiple times inside the loop. `git submodule status` without arguments outputs the status for all submodules. Calling it once and parsing the output is much faster than spawning multiple `git` processes inside a loop.
**Action:** Use a single `git submodule status` call and parse the output rather than executing git commands inside a loop.
