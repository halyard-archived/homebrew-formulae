require 'formula'

class OpensshHalyard < Formula
  homepage 'http://www.openssh.com/'
  version '7.3p1'
  revision 1
  url "http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-#{version}.tar.gz"
  sha256 '3ffb989a6dcaa69594c3b550d4855a5a2e1718ccdde7f5e36387b424220fbecc'

  depends_on 'autoconf' => :build
  depends_on 'openssl'
  depends_on 'ldns' => :optional
  depends_on 'pkg-config' => :build if build.with? "ldns"

  patch_base = 'https://raw.githubusercontent.com/halyard/homebrew-formulae/master/Patches'

  patch do
    url "#{patch_base}/openssh-halyard-0001-sandbox.patch"
    sha256 '0963bcaeabfc8a1b8db7de1a0901725b7e18d7d807a7ee211b963e4cf34d4b91'
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
