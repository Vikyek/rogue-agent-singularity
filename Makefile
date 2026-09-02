PREFIX ?= /usr
DESTDIR ?=

.PHONY: all submodules install

all: submodules

submodules:
	@if [ -d .git ]; then \
		echo "Initializing submodules..."; \
		git submodule update --init --recursive; \
	else \
		echo "Not a git repository. Skipping submodule initialization."; \
	fi

install: submodules
	install -Dm755 vras-submodule $(DESTDIR)$(PREFIX)/bin/vras-submodule
	ln -sf vras-submodule $(DESTDIR)$(PREFIX)/bin/vras
	install -Dm644 man1/vras-submodule.1 $(DESTDIR)$(PREFIX)/share/man/man1/vras-submodule.1
	ln -sf vras-submodule.1 $(DESTDIR)$(PREFIX)/share/man/man1/vras.1
	install -Dm644 README.md $(DESTDIR)$(PREFIX)/share/doc/rogue-agent-singularity/README.md
	install -Dm644 LICENSE $(DESTDIR)$(PREFIX)/share/licenses/rogue-agent-singularity/LICENSE
