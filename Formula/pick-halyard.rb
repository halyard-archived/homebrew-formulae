class PickHalyard < Formula
  desc "Command line arg picker"
  homepage "https://github.com/thoughtbot/pick"
  version = "1.9.0"
  url "https://github.com/thoughtbot/pick/releases/download/v#{version}/pick-#{version}.tar.gz"
  sha256 "97d3f310eb7de44fbe50ad3451c49d859d607fa14acd0c584aafae97eea65267"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pick", "-v"
  end
end
