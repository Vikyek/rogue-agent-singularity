## 2024-05-24 - Semantic Logging in Shell Scripts
**Learning:** Raw `echo` statements in setup scripts lead to unstructured walls of text. Standardized functions (`info`, `warn`, `error`, `success`) equipped with ANSI colors significantly improve developer scannability, provided they check `NO_COLOR` and route errors to stderr.
**Action:** Always implement and use a `NO_COLOR`-compliant logging block with proper stdout/stderr separation instead of plain `echo` for long shell setup sequences. Use `>/dev/null` for spammy standard command outputs (like `pip install`) to keep logs concise while preserving their internal error traces.

## 2024-05-24 - Truncating and Dimming Auxiliary Text
**Learning:** Long metadata strings (like 40-character commit hashes) and static text (e.g., 'uninitialized') clutter terminal outputs and make them harder to scan.
**Action:** Truncate long hashes (e.g., to 7 characters) and use dim ANSI coloring (\e[2m) for metadata to reduce visual noise and maintain hierarchy in lists.

## 2025-01-18 - Truncating and Dimming Auxiliary Output
**Learning:** Printing full 40-character commit hashes and static metadata like "uninitialized" creates unnecessary visual noise in terminal lists.
**Action:** Truncate long hashes (e.g. to 7 characters) while preserving status prefixes (+, -, U), and use ANSI dim styling (\e[2m) for all auxiliary text to maintain visual hierarchy.

## 2024-05-24 - Dimming auxiliary metadata
**Learning:** When printing long metadata strings (like 40-character commit hashes) or auxiliary static text (e.g., 'uninitialized') in terminal lists, truncate them (e.g., to 7 characters) and use dim ANSI coloring ([2m) to reduce visual noise and maintain visual hierarchy.
**Action:** Apply dim formatting to supplementary or noisy data points when presenting lists in CLI outputs.

## 2026-09-21 - Visual Hierarchy in Terminal Lists
**Learning:** Printing full 40-character commit hashes and static informational text in terminal lists creates visual noise and reduces readability.
**Action:** When printing long metadata strings (like commit hashes) in terminal lists, truncate them (e.g., to 7 characters) and use dim ANSI coloring (\e[2m) for them and other auxiliary text to reduce visual noise and maintain visual hierarchy.

## 2024-10-27 - Dimming and Truncating Hashes in Terminal Lists
**Learning:** Printing long metadata strings (like 40-character commit hashes) clutters terminal list outputs. Truncating them (e.g., to 7 characters) and using dim ANSI coloring (`\e[2m`) significantly reduces visual noise and improves visual hierarchy without losing readability.
**Action:** When printing long metadata strings in terminal lists, truncate them and use dim ANSI coloring (`\e[2m`) to reduce visual noise while maintaining the core structure.

## 2024-05-27 - Truncating and dimming Git Hashes
**Learning:** 40-character git hashes in lists create a lot of visual noise. Extracting the first 7 chars and applying dim formatting (\e[2m) makes terminal lists much more readable while preserving essential identity info.
**Action:** Always truncate long metadata strings (like hashes) in console lists, and use dim formatting to push them visually behind primary information like module names or statuses.

## 2024-09-18 - Truncating and dimming Git commit hashes in lists
**Learning:** Long 40-character commit hashes in terminal list outputs create significant visual noise and distract from the primary status information (like ENABLED/DISABLED). Additionally, Bash regex matching with hyphenated classes (e.g. `^[-+U]`) requires the hyphen to be the first or last character to avoid being treated as a range.
**Action:** When printing long metadata strings (like commit hashes) in terminal lists, truncate them (e.g., to 7 characters after any `+`/`-`/`U` prefix) and use dim ANSI coloring (`\e[2m`) to reduce visual noise and maintain visual hierarchy while ensuring grepability.

## 2026-09-17 - Dim and truncate long commit hashes
**Learning:** When printing long metadata strings (like 40-character commit hashes) in terminal lists, truncate them (e.g., to 7 characters) and use dim ANSI coloring (\e[2m) to reduce visual noise and maintain visual hierarchy.
**Action:** Truncate to 7 characters and use `\e[2m` for metadata fields in list outputs.

## 2024-09-16 - Truncating Git Hashes for Scannability
**Learning:** Printing full 40-character Git hashes in terminal list commands creates unnecessary visual noise and horizontal scrolling, harming readability.
**Action:** When printing Git commit hashes in terminal outputs, extract and display only the first 7 characters (the standard short hash length). Use dim ANSI color styling (`\e[2m`) to de-emphasize this metadata compared to the primary list items, and ensure proper extraction of any Git status prefix flags (like `+`, `-`, `U`) before truncating. Always verify that `NO_COLOR` logic is properly handled.

## 2024-05-24 - Visual Hierarchy for Hashes and Metadata
**Learning:** Printing long metadata strings (like 40-character commit hashes) in lists overpowers primary information like the module name and status. Applying dim color (`\e[2m`) and truncating the hashes restores focus to what developers actually need to scan.
**Action:** When printing lists of entities alongside metadata (like commit hashes, paths, or labels like "uninitialized"), aggressively truncate hashes to 7 characters and wrap them in dim coloring to de-emphasize them visually.

## 2026-09-10 - Inverted NO_COLOR logic
**Learning:** Checking `[[ -v NO_COLOR ]]` to enable colors is an anti-pattern that breaks standard CLI UX guidelines. `NO_COLOR` should be used to disable colors when set, not enable them.
**Action:** Always use `if [[ -z "${NO_COLOR:-}" ]]; then` to enable colors by default and disable them when `NO_COLOR` is present.
