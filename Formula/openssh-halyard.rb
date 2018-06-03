class OpensshHalyard < Formula
  desc "SSH client and server"
  homepage "http://www.openssh.com/"
  url "http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.7p1.tar.gz"
  version "7.7p1"
  sha256 "d73be7e684e99efcd024be15a30bffcbe41b012b2f7b3c9084aed621775e6b8f"
  revision 1

  depends_on "autoconf" => :build
  depends_on "openssl"
  depends_on "ldns" => :optional
  depends_on "pkg-config" => :build

  patch_base = "https://raw.githubusercontent.com/halyard/homebrew-formulae/master/Patches"

  patch do
    url "#{patch_base}/openssh-halyard-0001-sandbox.patch"
    sha256 "0963bcaeabfc8a1b8db7de1a0901725b7e18d7d807a7ee211b963e4cf34d4b91"
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
    system "make", "install"
  end

  test do
    system bin/"ssh", "--version"
  end
end
