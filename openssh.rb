require 'formula'

class Openssh < Formula
  homepage 'http://www.openssh.com/'
  version '6.7p1'
  url "http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-#{version}.tar.gz"
  sha256 'b2f8394eae858dabbdef7dac10b99aec00c95462753e80342e530bbb6f725507'

  depends_on 'autoconf' => :build
  depends_on 'openssl'
  depends_on 'ldns' => :optional
  depends_on 'pkg-config' => :build if build.with? "ldns"

  patch do
    url 'https://gist.githubusercontent.com/akerl/66872c64639d2d6ff333/raw/2f6a8e92dabd58cc4ce5bd11ca0759d3fc5a811f/0003-Apple-keychain-integration-other-changes.patch'
    sha256 'f35f4a1cde86a9158189d8249e56a21327e30eb2b228e554bf607722b7d4fef1'
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
