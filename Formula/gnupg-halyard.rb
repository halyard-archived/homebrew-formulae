require 'formula'

class GnupgHalyard < Formula
  homepage 'https://www.gnupg.org/'
  version '2.1.10'
  url "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-#{version}.tar.bz2"
  sha256 '93bd58d81771a4fa488566e5d2e13b1fd7afc86789401eb41731882abfd26cf9'

  option "with-gpgsplit", "Additionally install the gpgsplit utility"

  depends_on "pkg-config" => :build
  depends_on "npth"
  depends_on "gnutls"
  depends_on "libgpg-error"
  depends_on "libgcrypt"
  depends_on "libksba"
  depends_on "libassuan"
  depends_on "pinentry"
  depends_on "libusb-compat" => :recommended
  depends_on "readline" => :optional
  depends_on "gettext"

  conflicts_with 'gpg-agent', :because => 'This GnuPG 2.1 includes gpg-agent'
  conflicts_with 'dirmngr', :because => 'This GnuPG 2.1 includes dirmngr'
  conflicts_with 'gnupg2', :because => 'This GnuPG 2.1 includes gnupg2 (duh)'
  conflicts_with 'gnupg', :because => 'This GnuPG is better than GnuPG1'

  def install
    (var/"run").mkpath

    ENV.append "LDFLAGS", "-lresolv"
    ENV["gl_cv_absolute_stdint_h"] = "#{MacOS.sdk_path}/usr/include/stdint.h"

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --sbindir=#{bin}
      --sysconfdir=#{etc}
      --enable-symcryptrun
      --with-pinentry-pgm=#{Formula["pinentry"].opt_bin}/pinentry
    ]

    args << "--with-readline=#{Formula["readline"].opt_prefix}" if build.with? "readline"

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


    # Conflicts with a manpage from the 1.x formula, and
    # gpg-zip isn't installed by this formula anyway
    rm man1/"gpg-zip.1"
    mv share/"info/gnupg.info", share/"info/gnupg21.info"
    mv man7/"gnupg.7", man7/"gnupg2.7"
  end

  test do
    system "#{bin}/gpgconf"
  end
end
