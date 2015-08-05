require 'formula'

class OpensshHalyard < Formula
  homepage 'http://www.openssh.com/'
  version '6.9p1'
  url "http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-#{version}.tar.gz"
  sha256 '6e074df538f357d440be6cf93dc581a21f22d39e236f217fcd8eacbb6c896cfe'

  depends_on 'autoconf' => :build
  depends_on 'openssl'
  depends_on 'ldns' => :optional
  depends_on 'pkg-config' => :build if build.with? "ldns"

  patch do
    url 'https://raw.githubusercontent.com/halyard/homebrew-formulae/master/Patches/0001-openssh-keychain.patch'
    sha256 'd012594430333624434ab21fd54be8353ce4c72cdff7c42d2e5b6794273c3e23'
  end

  patch do
    url 'https://raw.githubusercontent.com/halyard/homebrew-formulae/master/Patches/0002-openssh-pam.patch'
    sha256 'df3feaf0c637ee486017355ec1d0dce387aa315968ed81000ffb0bcf628839ed'
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
