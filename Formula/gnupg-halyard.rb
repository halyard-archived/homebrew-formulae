class GnupgHalyard < Formula
  desc "GNU Privacy Guard: a free PGP replacement"
  homepage "https://www.gnupg.org/"
  url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.23.tar.bz2"
  sha256 "a94476391595e9351f219188767a9d6ea128e83be5ed3226a7890f49aa2d0d77"

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

  # Upstream commit 16 May 2017 "Suppress error for card availability check."
  # See https://dev.gnupg.org/rGa8dd96826f8484c0ae93c954035b95c2a75c80f2
  patch do
    url "https://dev.gnupg.org/rGa8dd96826f8484c0ae93c954035b95c2a75c80f2?diff=1"
    sha256 "3adb7fd095f8bc29fd550bf499f5f198dd20e3d5c97d5bcb79e91d95fd53a781"
  end

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
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
    system "make", "check"

    # Add symlinks from gpg2 to unversioned executables, replacing gpg 1.x.
    bin.install_symlink "gpg2" => "gpg"
    bin.install_symlink "gpgv2" => "gpgv"
    man1.install_symlink "gpg2.1" => "gpg.1"
    man1.install_symlink "gpgv2.1" => "gpgv.1"
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
