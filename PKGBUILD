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
source=("$pkgname-$pkgver.tar.gz::$url/archive/refs/tags/v$pkgver.tar.gz" "vras-submodule" "vras-submodule.1::man1/vras-submodule.1")
sha256sums=('SKIP' 'SKIP' 'SKIP')

package() {
    cd "$pkgname-$pkgver"
    install -Dm755 "$srcdir/vras-submodule" "$pkgdir/usr/bin/vras-submodule"
    ln -s vras-submodule "$pkgdir/usr/bin/vras"

    install -Dm644 "$srcdir/vras-submodule.1" "$pkgdir/usr/share/man/man1/vras-submodule.1"
    ln -s vras-submodule.1 "$pkgdir/usr/share/man/man1/vras.1"

    install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
