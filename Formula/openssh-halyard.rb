require 'formula'

class OpensshHalyard < Formula
  homepage 'http://www.openssh.com/'
  version '7.1p2'
  revision 1
  url "http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-#{version}.tar.gz"
  sha256 'dd75f024dcf21e06a0d6421d582690bf987a1f6323e32ad6619392f3bfde6bbd'

  depends_on 'autoconf' => :build
  depends_on 'openssl'
  depends_on 'ldns' => :optional
  depends_on 'pkg-config' => :build if build.with? "ldns"

  patch_base = 'https://raw.githubusercontent.com/halyard/homebrew-formulae/master/Patches'

  patch do
    url "#{patch_base}/openssh-halyard-0001-sandbox.patch"
    sha256 '82c287053eed12ce064f0b180eac2ae995a2b97c6cc38ad1bdd7626016204205'
  end

  def install
    ENV.append "CPPFLAGS", "-D__APPLE_SANDBOX_NAMED_EXTERNAL__" if OS.mac?

    args = %W[
      --with-libedit
      --with-pam
      --with-kerberos5
      --prefix=#{prefix}
      --sysconfdir=#{etc}/ssh
      --with-ssl-dir=#{Formula["openssl"].opt_prefix}
    ]

    args << "--with-ldns" if build.with? "ldns"

    system "./configure", *args
    system "make"
    system "make install"
  end
end
