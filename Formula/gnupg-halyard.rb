require 'formula'

class GnupgHalyard < Formula
  homepage 'https://www.gnupg.org/'
  version '2.1.9'
  url "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-#{version}.tar.bz2"
  sha256 '1cb7633a57190beb66f9249cb7446603229b273d4d89331b75c652fa4a29f7b6'
  revision 1

  patch_base = 'https://raw.githubusercontent.com/halyard/homebrew-formulae/master/Patches'

  patch do
    url "#{patch_base}/gnupg-halyard-0001-makefile.patch"
    sha256 '48c15fa61a6ca03fad78db879415996ec37a7c117e186ef720c6f71cd79f8093'
  end
  patch do
    url "#{patch_base}/gnupg-halyard-0002-makefile.patch"
    sha256 '899166d8e56b2c953ff6324a0f6b8b52ff5d368ce0dd3cdc45fb1a3fe8ec6859'
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
  conflicts_with 'gnupg2', :because => 'This GnuPG 2.1 includes gnupg2 (duh)'
  conflicts_with 'gnupg', :because => 'This GnuPG is better than GnuPG1'

  def install
    inreplace 'configure' do |s|
      s.gsub! "PACKAGE_NAME='gnupg'", "PACKAGE_NAME='gnupg2'"
      s.gsub! "PACKAGE_TARNAME='gnupg'", "PACKAGE_TARNAME='gnupg2'"
    end
    inreplace 'tools/gpgkey2ssh.c', 'gpg --list-keys', 'gpg2 --list-keys'

    inreplace 'g10/keygen.c', 'max=4096', 'max=8192'

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
    ln_sf "#{bin}/gpg2", "#{bin}/gpg"

    # Conflicts with a manpage from the 1.x formula, and
    # gpg-zip isn't installed by this formula anyway
    rm man1/'gpg-zip.1'
  end
end
