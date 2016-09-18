class Krb5Pkinit < Formula
  desc "Network authentication protocol"
  homepage "http://web.mit.edu/kerberos/"
  url "http://web.mit.edu/kerberos/dist/krb5/1.14/krb5-1.14.2.tar.gz"
  sha256 "6bcad7e6778d1965e4ce4af21d2efdc15b274c5ce5c69031c58e4c954cda8b27"

  bottle do
    root_url "https://github.com/halyard/homebrew-formulae/releases/download/krb5-pkinit-1.14.2"
    sha256 "5168c2c12be410fe3c6ced1318086036fb41e2492e6a95e01bea29c6f2a6726c" => :el_capitan
  end

  keg_only :provided_by_osx

  depends_on "openssl"
  depends_on "bison" unless OS.mac?

  def install
    cd "src" do
      system "./configure",
        "--disable-debug",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--prefix=#{prefix}",
        "--enable-pkinit"
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/krb5-config", "--version"
    assert_match include.to_s,
      shell_output("#{bin}/krb5-config --cflags")
  end
end
