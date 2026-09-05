PREFIX ?= /usr
DESTDIR ?=

.PHONY: all submodules install

all: submodules

submodules:
	@if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then \
		echo "Initializing submodules..."; \
		git submodule update --init --recursive || echo "Warning: git submodule update failed (ignoring for offline builds)"; \
	else \
		echo "Not a git repository. Skipping submodule initialization."; \
	fi

install: submodules
	install -dm755 $(DESTDIR)$(PREFIX)/share/rogue-agent-singularity
	cp -a agv-dispatcher agv-syncengine toon-mcp jules-vanager vras-submodule $(DESTDIR)$(PREFIX)/share/rogue-agent-singularity/ 2>/dev/null || true
	install -Dm755 vras-submodule $(DESTDIR)$(PREFIX)/share/rogue-agent-singularity/vras-submodule
	install -dm755 $(DESTDIR)$(PREFIX)/bin
	ln -sf ../share/rogue-agent-singularity/vras-submodule $(DESTDIR)$(PREFIX)/bin/vras
	ln -sf ../share/rogue-agent-singularity/vras-submodule $(DESTDIR)$(PREFIX)/bin/vras-submodule
	install -Dm644 man1/vras-submodule.1 $(DESTDIR)$(PREFIX)/share/man/man1/vras-submodule.1
	ln -sf vras-submodule.1 $(DESTDIR)$(PREFIX)/share/man/man1/vras.1
	install -Dm644 README.md $(DESTDIR)$(PREFIX)/share/doc/rogue-agent-singularity/README.md
	install -Dm644 LICENSE $(DESTDIR)$(PREFIX)/share/licenses/rogue-agent-singularity/LICENSE
