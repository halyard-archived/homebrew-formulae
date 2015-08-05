require 'formula'

class GnupgHalyard < Formula
  homepage 'https://www.gnupg.org/'
  version '2.1.6'
  url "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-#{version}.tar.bz2"
  sha256 '5e599ad542199f3bd733eed2b88a539d1b4c3beda2dbab0ff69f1896f52e92fd'

  patch do
    url 'https://raw.githubusercontent.com/halyard/homebrew-formulae/master/Patches/gnupg-halyard-0001-makefile.patch'
    sha256 'ff5248765977cba3fcfedd36f498c5ee2eeb244be371b4cd19098bbd37aeec5a'
  end
  patch do
    url 'https://raw.githubusercontent.com/halyard/homebrew-formulae/master/Patches/gnupg-halyard-0002-makefile.patch'
    sha256 '7bc0469a56e7e1b4a714491e88fca7cadc4eebad9bb76a841a55880f220d8a7e'
  end

  depends_on 'libgpg-error'
  depends_on 'libgcrypt'
  depends_on 'libksba'
  depends_on 'libassuan'
  depends_on 'pinentry'
  depends_on 'npth'
  depends_on 'libusb-compat' => :recommended
  depends_on 'readline' => :optional
  depends_on 'pkg-config' => :build
  depends_on 'gnutls' => :optional

  conflicts_with 'gpg-agent', :because => 'This GnuPG 2.1 includes gpg-agent'
  conflicts_with 'dirmngr', :because => 'This GnuPG 2.1 includes dirmngr'

  def install
    inreplace 'configure' do |s|
      s.gsub! "PACKAGE_NAME='gnupg'", "PACKAGE_NAME='gnupg2'"
      s.gsub! "PACKAGE_TARNAME='gnupg'", "PACKAGE_TARNAME='gnupg2'"
    end
    inreplace 'tools/gpgkey2ssh.c', 'gpg --list-keys', 'gpg2 --list-keys'

    (var/'run').mkpath

    ENV.append 'LDFLAGS', '-lresolv'

    ENV['gl_cv_absolute_stdint_h'] = "#{MacOS.sdk_path}/usr/include/stdint.h"

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sbindir=#{bin}
      --enable-symcryptrun
    ]

    if build.with? 'readline'
      args << "--with-readline=#{Formula['readline'].opt_prefix}"
    end

    system './configure', *args
    system 'make'
    system 'make', 'check'
    system 'make', 'install'

    # Conflicts with a manpage from the 1.x formula, and
    # gpg-zip isn't installed by this formula anyway
    rm man1/'gpg-zip.1'
  end
end
