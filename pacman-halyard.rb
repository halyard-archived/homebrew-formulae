require 'formula'

class PacmanHalyard < Formula
  version '4.2.1'
  sha256 'a142593c409ef21f6fde0075c7649a58a8ee0edbd2af3f82e4dc05cfc1d0b545'

  url "https://sources.archlinux.org/other/pacman/pacman-#{version}.tar.gz"
  homepage 'https://www.archlinux.org/pacman/'

  depends_on 'libarchive'
  depends_on 'pkg-config'
  depends_on 'bash'

  def install
    ENV.prepend_path 'PKG_CONFIG_PATH', "#{Formula['libarchive'].lib}/pkgconfig"
    ENV['CPATH'] = "-I#{Formula['libarchive'].include}"
    ENV['BASH_SHELL'] = "#{Formula['bash'].bin}/bash"
    system "./configure --prefix=#{prefix}"
    system 'make'
    system 'make install'
    mkdir_p "#{prefix}/var/lib/pacman"
  end
end
