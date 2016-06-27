class Krb5Pkinit < Formula
  desc "Network authentication protocol"
  homepage "http://web.mit.edu/kerberos/"
  url "http://web.mit.edu/kerberos/dist/krb5/1.14/krb5-1.14.tar.gz"
  sha256 "cedb07fad8331e3ff2983d26e977a2ddba622f379c2b19bfea85bd695930f9e9"

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
