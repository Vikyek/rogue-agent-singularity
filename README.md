# 🌌 Vikyek's Rogue Agent Singularity (VRAS)

A unified suite of autonomous multi-agent tools, orchestrators, integration plugins, and configuration vault synchronization systems built for Antigravity (AGY).

---

## 📦 Core Ecosystem Components

| Component | Description | Repository |
| :--- | :--- | :--- |
| **`agv-dispatcher`** | Token-efficient 5-tier task dispatcher, dual-provider quota balancing, and MCP tool schema pruning system. | [`Vikyek/agv-dispatcher`](https://github.com/Vikyek/agv-dispatcher) |
| **`jules-vanager`** | Standalone Google Jules API Manager, Listener Daemon, Interactive TUI, and Conky HUD widget. | [`Vikyek/jules-vanager`](https://github.com/Vikyek/jules-vanager) |
| **`agv-syncengine`** | Public template & engine for rule compaction, private vault synchronization, and conflict resolution. | [`Vikyek/agv-syncengine`](https://github.com/Vikyek/agv-syncengine) |
| **`toon-mcp`** | Structured payload token optimization MCP server (TOON format). | [`Vikyek/toon-mcp`](https://github.com/Vikyek/toon-mcp) |

---

## 🎛️ Submodule Management (`vras` / `vras-submodule` CLI)

Manage and toggle VRAS submodules easily using the built-in `vras` command-line utility:

```bash
vras [list|enable|disable|toggle] [module]
```

### Commands:
- `vras list`: Display status (`ENABLED`/`DISABLED`) and git commit SHA of all submodules.
- `vras enable <module|all>`: Initialize and checkout the specified submodule (or all).
- `vras disable <module|all>`: Deinitialize and clear the specified submodule (or all).
- `vras toggle <module>`: Toggle the specified submodule on or off.

### Module Shortcuts:
`dispatcher` (`agv-dispatcher`), `jules` (`jules-vanager`), `sync` (`agv-syncengine`), `toon` (`toon-mcp`), `all`.

---

## ⚡ Maximum Token Savings Setup (`toon-mcp` + `agv-dispatcher`)

To achieve maximum token savings (35–60% payload compression):

1. **Install `toon-mcp` into isolated virtual environment**:
   ```bash
   python3 -m venv ~/.local/share/toon-venv
   ~/.local/share/toon-venv/bin/pip install -e ~/.gemini/config/plugins/rogue-agent-singularity/toon-mcp
   ```

2. **Register `toon` MCP Server**:
   Add to `~/.gemini/config/mcp_config.json`:
   ```json
   {
     "mcpServers": {
       "toon": {
         "command": "/home/v/.local/share/toon-venv/bin/toon-mcp-server",
         "args": []
       }
     }
   }
   ```

3. **Orchestrator Activation**:
   `agv-dispatcher` automatically writes pruned MCP configuration templates inside worker subagent workspaces, exposing `toon` tools (`convert_to_toon` / `convert_to_json`) for high-volume JSON data payloads.

---

## 🛠️ Setup & Installation

Clone the full ecosystem with submodules:

```bash
git clone --recursive https://github.com/Vikyek/rogue-agent-singularity.git ~/.gemini/config/plugins/rogue-agent-singularity
```

### Man Page & CLI Access
```bash
man vras-submodule
vras --help
```


---

## Support & Sponsorship

`rogue-agent-singularity` is authored and maintained by **[Vikyek](https://github.com/Vikyek)** as an independent open-source project. Everything is 100% open-source, telemetry-free, and public.

<div align="center">

<!-- Official GitHub Sponsors Button & Card (Rendered in web/HTML environments; GitHub markdown sanitizer strips iframes, falling back to native badges) -->
<iframe src="https://github.com/sponsors/Vikyek/button" title="Sponsor Vikyek" height="32" width="114" style="border: 0; border-radius: 6px;"></iframe>
<iframe src="https://github.com/sponsors/Vikyek/card" title="Sponsor Vikyek" height="225" width="600" style="border: 0;"></iframe>

[![Sponsor Vikyek](https://img.shields.io/badge/Sponsor-%E2%9D%A4-ea4aaa?logo=github&style=for-the-badge)](https://github.com/sponsors/Vikyek)
[![Donate on Liberapay](https://img.shields.io/badge/Donate-Liberapay-f6c915?style=for-the-badge&logo=liberapay&logoColor=black)](https://liberapay.com/Vikyek)
[![Sponsor on Polar](https://img.shields.io/badge/Sponsor-Polar-0062FF?style=for-the-badge&logo=polar&logoColor=white)](https://polar.sh/vikyek)
[![Donate with Stripe](https://img.shields.io/badge/Donate-Stripe-635BFF?style=for-the-badge&logo=stripe&logoColor=white)](https://profile.stripe.com/@vikyek)

</div>

> ### 🎯 Active Sponsorship Goal: Monthly Living Essentials
> **Target:** **2,710 PLN / ~$675 USD per month** (`630 PLN / week`) — Rent & Essential Utilities  
> Covering basic living essentials directly unlocks dedicated, sustainable full-time independent open-source engineering across Arch Linux utilities, developer tools, and AI middleware free from corporate telemetry, ads, or paywalls.

If this project saves you time, optimizes your setup, or accelerates your workflow, consider supporting ongoing work:

- **GitHub Sponsors**: [github.com/sponsors/Vikyek](https://github.com/sponsors/Vikyek) *(Monthly tiers and one-time tips)*
- **Liberapay**: [liberapay.com/Vikyek](https://liberapay.com/Vikyek) *(0% platform fee recurrent patronage in EUR/USD/PLN)*
- **Polar**: [polar.sh/vikyek](https://polar.sh/vikyek) *(Developer subscriptions & commercial passes)*
- **Direct Stripe Profile**: [profile.stripe.com/@vikyek](https://profile.stripe.com/@vikyek) *(Direct one-time tips & sponsorship)*

Every contribution—monthly or one-time—directly supports active maintenance, hardware testbeds, and new feature development!

---

## 📜 License

Distributed under the MIT License. See [`LICENSE`](LICENSE) for details.
