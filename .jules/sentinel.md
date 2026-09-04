## 2025-03-08 - Path Traversal / SSRF in API Wrapper
**Vulnerability:** The `jules_manager.py` API wrapper dynamically appended `session_id` to its API URL endpoints without sanitizing the input. This allowed Path Traversal (`../../`) to be injected into the URL via the CLI argument, potentially causing SSRF against Google's API endpoints.
**Learning:** URL paths constructed dynamically from user input need sanitization.
**Prevention:** Always use `urllib.parse.quote(id, safe="")` before injecting identifiers into URL paths.
