# Maintainer: Vikyek <https://github.com/Vikyek>
pkgname=rogue-agent-singularity
pkgver=1.0.0
pkgrel=2
pkgdesc="Vikyek's Rogue Agent Singularity — Suite of autonomous multi-agent tools, orchestrators, and plugins for Antigravity (AGY)"
arch=('any')
url="https://github.com/Vikyek/rogue-agent-singularity"
license=('MIT')
depends=('python' 'git' 'bash')
optdepends=(
    'agv-dispatcher: Token-efficient task dispatcher & self-scaling orchestrator'
    'jules-vanager: Google Jules API Manager, Listener Daemon, TUI, and Conky HUD'
    'agv-syncengine: Preference vault sync template and conflict resolution engine'
    'toon-mcp: TOON-format token optimization MCP server'
)
source=("git+https://github.com/Vikyek/rogue-agent-singularity.git#tag=v$pkgver")
sha256sums=('SKIP')

package() {
    cd "$pkgname"
    make install DESTDIR="$pkgdir" PREFIX=/usr
}
