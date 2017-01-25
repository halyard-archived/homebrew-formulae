class PickHalyard < Formula
  desc "Command line arg picker"
  homepage "https://github.com/thoughtbot/pick"
  _version = "1.5.4"
  url "https://github.com/thoughtbot/pick/releases/download/v#{_version}/pick-#{_version}.tar.gz"
  sha256 "61de8057b1955501a8fc38227eb3ad9430bb8617480ca32c648e03c3f2c29253"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pick", "-v"
  end
end
