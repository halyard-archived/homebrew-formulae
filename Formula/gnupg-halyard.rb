class GnupgHalyard < Formula
  desc "GNU Privacy Guard: a free PGP replacement"
  homepage "https://www.gnupg.org/"
  url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.3.tar.bz2"
  sha256 "cbd37105d139f7aa74f92b6f65d136658682094b0e308666b820ae4b984084b4"

  head do
    url "https://dev.gnupg.org/source/gnupg.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "npth"
  depends_on "gnutls"
  depends_on "libgpg-error"
  depends_on "libgcrypt"
  depends_on "libksba"
  depends_on "libassuan"
  depends_on "pinentry"
  depends_on "gettext"
  depends_on "adns"
  depends_on "readline"
  depends_on "libusb"

  conflicts_with "gpg-agent", :because => "This GnuPG 2.1 includes gpg-agent"
  conflicts_with "dirmngr", :because => "This GnuPG 2.1 includes dirmngr"
  conflicts_with "gnupg2", :because => "This GnuPG 2.1 includes gnupg2 (duh)"
  conflicts_with "gnupg", :because => "This GnuPG is better than GnuPG1"

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --sbindir=#{bin}
      --sysconfdir=#{etc}
      --enable-symcryptrun
      --with-pinentry-pgm=#{Formula["pinentry"].opt_bin}/pinentry
      --with-readline=#{Formula["readline"].opt_prefix}
      --enable-large-secmem
      --enable-all-tests
    ]

    if build.head?
      args << '--enable-maintainer-mode'
      system './autogen.sh'
      system 'autoconf'
    end
    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"
  end

  def post_install
    (var/"run").mkpath
    quiet_system "killall", "gpg-agent"
  end

  test do
    (testpath/"batch.gpg").write <<-EOS.undent
      Key-Type: RSA
      Key-Length: 2048
      Subkey-Type: RSA
      Subkey-Length: 2048
      Name-Real: Testing
      Name-Email: testing@foo.bar
      Expire-Date: 1d
      %no-protection
      %commit
    EOS
    begin
      system bin/"gpg", "--batch", "--gen-key", "batch.gpg"
      (testpath/"test.txt").write "Hello World!"
      system bin/"gpg", "--detach-sign", "test.txt"
      system bin/"gpg", "--verify", "test.txt.sig"
    ensure
      system bin/"gpgconf", "--kill", "gpg-agent"
    end
  end
end
