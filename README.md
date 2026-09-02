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

## 📜 License

Distributed under the MIT License. See [`LICENSE`](LICENSE) for details.
