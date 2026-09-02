# Maintainer: Vikyek <https://github.com/Vikyek>
pkgname=rouge-agent-singularity
pkgver=1.0.0
pkgrel=1
pkgdesc="Vikyek's Rouge Agent Singularity — Suite of autonomous multi-agent tools, orchestrators, and plugins for Antigravity (AGY)"
arch=('any')
url="https://github.com/Vikyek/rouge-agent-singularity"
license=('MIT')
depends=('python' 'git')
optdepends=(
    'agv-dispatcher: Token-efficient task dispatcher & self-scaling orchestrator'
    'jules-vanager: Google Jules API Manager, Listener Daemon, TUI, and Conky HUD'
    'toon-mcp: TOON-format token optimization MCP server'
)
source=("$pkgname-$pkgver.tar.gz::$url/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('SKIP')

package() {
    cd "$pkgname-$pkgver"
    install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
