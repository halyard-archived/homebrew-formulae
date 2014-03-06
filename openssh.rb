require 'formula'

class Openssh < Formula
  homepage 'http://www.openssh.com/'
  url 'http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.4p1.tar.gz'
  version '6.4p1'
  sha256 'cf5fe0eb118d7e4f9296fbc5d6884965885fc55d'

  option 'with-brewed-openssl', 'Build with Homebrew OpenSSL instead of the system version'
  option 'with-keychain-support', 'Add native OS X Keychain and Launch Daemon support to ssh-agent'
  option 'with-gssapi-support', 'Add support to GSSAPI key exchange'

  depends_on 'autoconf' => :build if build.with? 'keychain-support'
  depends_on 'openssl' if build.with? 'brewed-openssl'
  depends_on 'ldns' => :optional
  depends_on 'pkg-config' => :build if build.with? "ldns"

  def patches
    p = []
    # Apply a revised version of Simon Wilkinson's gsskex patch (http://www.sxw.org.uk/computing/patches/openssh.html), which has also been included in Apple's openssh for a while
    p << 'https://trac.macports.org/export/112514/trunk/dports/net/openssh/files/0002-Apple-keychain-integration-other-changes.patch' if build.include? 'with-keychain-support'
    p << 'https://gist.github.com/kruton/8120594/raw/74cab9ac1fa02505547a6afd7cf5e6b2b2428ed8/gistfile1.txt' if build.include? 'with-keychain-support'
    p << 'https://trac.macports.org/export/112514/trunk/dports/net/openssh/files/openssh-6.3p1-gsskex-all-20130920.patch' if build.with? 'gssapi-support'
    p
  end

  def install
    system "autoreconf -i" if build.with? 'keychain-support'

    if build.include? "with-keychain-support"
        ENV.append "CPPFLAGS", "-D__APPLE_LAUNCHD__ -D__APPLE_KEYCHAIN__"
        ENV.append "LDFLAGS", "-framework CoreFoundation -framework SecurityFoundation -framework Security"
    end

    args = %W[
      --with-libedit
      --with-kerberos5
      --prefix=#{prefix}
      --sysconfdir=#{etc}/ssh
    ]

    args << "--with-ssl-dir=#{Formula["openssl"].opt_prefix}" if build.with? 'brewed-openssl'
    args << "--with-ldns" if build.with? "ldns"

    # Sometimes when Apple ships security update, the libraries get
    # updated while the headers don't. Disable header/library version
    # check when using system openssl to cope with this situation.
    args << "--without-openssl-header-check" if not build.with? 'brewed-openssl'

    system "./configure", *args
    system "make"
    system "make install"
  end

  def caveats
    if build.include? "with-keychain-support"
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
end
