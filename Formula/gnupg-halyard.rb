class GnupgHalyard < Formula
  desc "GNU Privacy Guard: a free PGP replacement"
  homepage "https://www.gnupg.org/"
  url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.18.tar.bz2"
  sha256 "d04c6fab7e5562ce4b915b22020e34d4c1a256847690cf149842264fc7cef994"

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
  depends_on "libusb-compat" => :recommended
  depends_on "libusb" => :linked if build.with? "libusb-compat"

  conflicts_with "gpg-agent", :because => "This GnuPG 2.1 includes gpg-agent"
  conflicts_with "dirmngr", :because => "This GnuPG 2.1 includes dirmngr"
  conflicts_with "gnupg2", :because => "This GnuPG 2.1 includes gnupg2 (duh)"
  conflicts_with "gnupg", :because => "This GnuPG is better than GnuPG1"

  def install
    # need for -lintl already fixed upstream; remove for gnupg > 2.1.14
    ENV.append "LDFLAGS", "-lresolv -lintl"

    ENV["gl_cv_absolute_stdint_h"] = "#{MacOS.sdk_path}/usr/include/stdint.h"

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

    # Adjust package name to fit our scheme of packaging both gnupg 1.x and
    # and 2.1.x and gpg-agent separately.
    inreplace "configure" do |s|
      s.gsub! "PACKAGE_NAME='gnupg'", "PACKAGE_NAME='gnupg2'"
      s.gsub! "PACKAGE_TARNAME='gnupg'", "PACKAGE_TARNAME='gnupg2'"
    end

    system "./configure", *args

    system "make"
    system "make", "check"
    system "make", "install"

    ln_sf "#{bin}/gpg2", "#{bin}/gpg"
    mv share/"info/gnupg.info", share/"info/gnupg2.info"
    mv man7/"gnupg.7", man7/"gnupg2.7"
  end

  def post_install
    (var/"run").mkpath
  end

  test do
    system "#{bin}/gpgconf"
  end
end
