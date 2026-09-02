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
source=("$pkgname-$pkgver.tar.gz::$url/archive/refs/tags/v$pkgver.tar.gz" "vras-submodule" "vras-submodule.1::man1/vras-submodule.1")
sha256sums=('SKIP' 'SKIP' 'SKIP')

package() {
    cd "$pkgname-$pkgver"
    make install DESTDIR="$pkgdir" PREFIX=/usr
}
