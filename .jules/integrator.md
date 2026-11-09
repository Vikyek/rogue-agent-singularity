## 2026-09-30 - Fix patch application in jules_setup.sh
**Learning:** Incorrect patch strip levels (`-p`) and conflicting patches can cause submodule configurations to fail. `jules_setup.sh` needs precise integration of submodule patches depending on their structure. Some patches might conflict if applied separately.
**Action:** Always verify `-p` levels for patches applied to submodules. When multiple patches modify the same file region, consolidate them into a single patch to avoid fuzz/conflict failures during automated execution.
