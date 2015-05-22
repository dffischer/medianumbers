# Maintainer: XZS <d dot f dot fischer at web dot de>
pkgname=medianumbers-git
pkgver=r0
pkgrel=1
pkgdesc="tools to manipulate video and audio time codes"
arch=('any')
url="https://github.com/dffischer/medianumbers/"
license=('GPL')
depends=('bash')
optdepends=('ffmpeg: for duration and stretch'
            'grep: for duration'
            'bc: for stretch')
makedepends=('ruby-ronn')

# template input; name=git

build() {
  cd "$_gitname"
  ronn --roff *.md
}

package() {
  cd "$_gitname"
  local bindir="$pkgdir/usr/bin"
  install -d "$bindir"
  for program in *.sh
  do
    install "$program" "$bindir/${program%.sh}"
  done
  install -Dm644 -t "$pkgdir/usr/share/man/man1" *.1
}
