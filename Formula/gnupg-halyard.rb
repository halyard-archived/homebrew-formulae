class GnupgHalyard < Formula
  desc "GNU Privacy Guard: a free PGP replacement"
  homepage "https://www.gnupg.org/"
  url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.1.20.tar.bz2"
  sha256 "24cf9a69369be64a9f6f8cc11a1be33ab7780ad77a6a1b93719438f49f69960d"

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
  depends_on "libusb" => :recommended

  conflicts_with "gpg-agent", :because => "This GnuPG 2.1 includes gpg-agent"
  conflicts_with "dirmngr", :because => "This GnuPG 2.1 includes dirmngr"
  conflicts_with "gnupg2", :because => "This GnuPG 2.1 includes gnupg2 (duh)"
  conflicts_with "gnupg", :because => "This GnuPG is better than GnuPG1"

  patch_base = "https://raw.githubusercontent.com/halyard/homebrew-formulae/master/Patches"

  patch do
    url "#{patch_base}/gnupg-halyard-0001-sandbox.patch"
    sha256 "f62f76fde0b699851877545802e9ebf28fde52797a71e418749f731afb4fbc68"
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

    # Adjust package name to fit our scheme of packaging both gnupg 1.x and
    # and 2.1.x and gpg-agent separately.
    inreplace "configure" do |s|
      s.gsub! "PACKAGE_NAME='gnupg'", "PACKAGE_NAME='gnupg2'"
      s.gsub! "PACKAGE_TARNAME='gnupg'", "PACKAGE_TARNAME='gnupg2'"
    end

    system "./configure", *args

    system "make"
    system "make", "install"
    system "make", "check"

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
