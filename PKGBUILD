# Maintainer: Vikyek <https://github.com/Vikyek>
pkgname=rogue-agent-singularity
pkgver=1.0.2
pkgrel=1
pkgdesc="Vikyek's Rogue Agent Singularity — Suite of autonomous multi-agent tools, orchestrators, and plugins for Antigravity (AGY)"
arch=('any')
url="https://github.com/Vikyek/rogue-agent-singularity"
license=('MIT')
depends=('python' 'git' 'bash')
makedepends=('git' 'make')
optdepends=(
    'agv-dispatcher: Token-efficient task dispatcher & self-scaling orchestrator'
    'jules-vanager: Google Jules API Manager, Listener Daemon, TUI, and Conky HUD'
    'agv-syncengine: Preference vault sync template and conflict resolution engine'
    'toon-mcp: TOON-format token optimization MCP server'
)
source=("git+https://github.com/Vikyek/rogue-agent-singularity.git#tag=v$pkgver"
        "agv-dispatcher::git+https://github.com/Vikyek/agv-dispatcher.git"
        "jules-vanager::git+https://github.com/Vikyek/jules-vanager.git"
        "agv-syncengine::git+https://github.com/Vikyek/agv-syncengine.git"
        "toon-mcp::git+https://github.com/Vikyek/toon-mcp.git")
sha256sums=('SKIP' 'SKIP' 'SKIP' 'SKIP' 'SKIP')

prepare() {
    cd "$pkgname"
    git submodule init
    git config submodule.agv-dispatcher.url "$srcdir/agv-dispatcher"
    git config submodule.jules-vanager.url "$srcdir/jules-vanager"
    git config submodule.agv-syncengine.url "$srcdir/agv-syncengine"
    git config submodule.toon-mcp.url "$srcdir/toon-mcp"
    git -c protocol.file.allow=always submodule update
}

package() {
    cd "$pkgname"
    export GIT_CEILING_DIRECTORIES="$srcdir"
    make install DESTDIR="$pkgdir" PREFIX=/usr
}
