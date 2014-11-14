require 'formula'

class IpmiutilHalyard < Formula
  homepage 'http://ipmiutil.sourceforge.net/'
  version '2.9.2'
  url "https://downloads.sourceforge.net/project/ipmiutil/ipmiutil-#{version}.tar.gz"
  sha256 'c32687d233390364a91d16920dcd7df80c06365ade9e51d74b2af5c5d1acead8'

  # Make ipmiutil treat Darwin as BSD
  patch :DATA

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-sha256",
                          "--enable-gpl"

    system "make", "TMPDIR=#{ENV['TMPDIR']}"
    # DESTDIR is needed to make everything go where we want it.
    system "make", "prefix=/",
                   "DESTDIR=#{prefix}",
                   "varto=#{var}/lib/#{name}",
                   "initto=#{etc}/init.d",
                   "sysdto=#{prefix}/#{name}",
                   "install"
  end

  test do
    system "#{bin}/ipmiutil", "delloem", "help"
  end
end

__END__
diff -u ./configure.bak ./configure
--- ./configure.bak 2012-09-18 23:19:11.000000000 +0800
+++ ./configure 2012-09-18 23:21:04.000000000 +0800
@@ -20983,7 +20983,7 @@
  OS_CFLAGS="-DLINUX $MD2_CFLAGS $cfwarn"
   else
      # usually "x$sysname" = "xFreeBSD", but allow NetBSD
-     echo $sysname | grep BSD >/dev/null 2>&1
+     echo $sysname | grep 'BSD\|Darwin' >/dev/null 2>&1
      if test $? -eq 0; then
  os=bsd
  OS_CFLAGS="-DBSD"
