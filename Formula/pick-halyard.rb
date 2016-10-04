class PickHalyard < Formula
  desc "Command line arg picker"
  homepage "https://github.com/thoughtbot/pick"
  _version = "1.5.0"
  url "https://github.com/thoughtbot/pick/releases/download/v#{_version}/pick-#{_version}.tar.gz"
  sha256 "1dac1c9cf0b14b0bbb4d9eefb6af72cdf5314af7b2ff9e4c7c8858014ad63549"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pick", "-v"
  end
end
