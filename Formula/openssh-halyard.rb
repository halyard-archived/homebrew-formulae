require 'formula'

class OpensshHalyard < Formula
  homepage 'http://www.openssh.com/'
  version '7.1p1'
  revision 2
  url "http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-#{version}.tar.gz"
  sha256 'fc0a6d2d1d063d5c66dffd952493d0cda256cad204f681de0f84ef85b2ad8428'

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
    system "autoreconf -i"

    ENV.append "CPPFLAGS", "-D__APPLE_LAUNCHD__ -D__APPLE_KEYCHAIN__"
    ENV.append "LDFLAGS", "-framework CoreFoundation -framework SecurityFoundation -framework Security"

    args = %W[
      --with-libedit
      --with-pam
      --with-kerberos5
      --prefix=#{prefix}
      --sysconfdir=#{etc}/ssh
      --with-ssl-dir=#{Formula["openssl"].opt_prefix}
    ]

    args << "--with-ldns" if build.with? "ldns"

    # Sometimes when Apple ships security update, the libraries get
    # updated while the headers don't. Disable header/library version
    # check when using system openssl to cope with this situation.
    args << "--without-openssl-header-check"

    system "./configure", *args
    system "make"
    system "make install"
  end

  def caveats
    <<-EOS.undent
      For complete functionality, please modify:
        /System/Library/LaunchAgents/org.openbsd.ssh-agent.plist

      and change ProgramArugments from
        /usr/bin/ssh-agent
      to
        #{HOMEBREW_PREFIX}/bin/ssh-agent

      After that, you can start storing private key passwords in
      your OS X Keychain.
    EOS
  end
end
