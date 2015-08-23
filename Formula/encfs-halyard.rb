require 'formula'

class EncfsHalyard < Formula
  desc 'Encrypted pass-through FUSE file system'
  homepage 'https://vgough.github.io/encfs/'
  version '1.8.1'
  url "https://github.com/vgough/encfs/archive/v#{version}.tar.gz"
  sha256 'ed6b69d8aba06382ad01116bbce2e4ad49f8de85cdf4e2fab7ee4ac82af537e9'
  head 'https://github.com/vgough/encfs.git'

  depends_on 'pkg-config' => :build
  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext' => :build
  depends_on 'boost'
  depends_on 'rlog'
  depends_on 'openssl'
  depends_on 'xz'

  needs :cxx11

  def install
    ENV.cxx11
    system "make", "-f", "Makefile.dist"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-boost=#{HOMEBREW_PREFIX}"
    system "make"
    system "make", "install"
  end

  test do
    if Pathname.new("/Library/Filesystems/osxfusefs.fs/Support/load_osxfusefs").exist?
      (testpath/"print-password").write("#!/bin/sh\necho password")
      chmod 0755, testpath/"print-password"
      system "yes | #{bin}/encfs --standard --extpass=#{testpath}/print-password #{testpath}/a #{testpath}/b"
      system "umount", testpath/"b"
    end
  end
end
