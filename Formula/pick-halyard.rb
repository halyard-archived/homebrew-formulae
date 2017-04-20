class PickHalyard < Formula
  desc "Command line arg picker"
  homepage "https://github.com/thoughtbot/pick"
  _version = "1.6.0"
  url "https://github.com/thoughtbot/pick/releases/download/v#{_version}/pick-#{_version}.tar.gz"
  sha256 "d034fd75256ccb3e8c6523196ac250b44b18170a6594944ed6d23d1bcabfae6a"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pick", "-v"
  end
end
