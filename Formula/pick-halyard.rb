class PickHalyard < Formula
  desc "Command line arg picker"
  homepage "https://github.com/thoughtbot/pick"
  _version = "1.5.3"
  url "https://github.com/thoughtbot/pick/releases/download/v#{_version}/pick-#{_version}.tar.gz"
  sha256 "925f5736cdc44455305678030b190e7ee359bd710af4cfaf0388d6d27e21bc93"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pick", "-v"
  end
end
