## 2024-09-06 - Semantic Setup Logging
**Learning:** Shell scripts automating environment configuration (`jules_setup.sh`) lacked clear visual distinction between information, warnings, and errors.
**Action:** Implemented semantic `log_info`, `log_warn`, `log_err`, and `log_succ` bash helper functions that properly pipe messages to stderr and conditionally omit ANSI escapes when `NO_COLOR` is set.
