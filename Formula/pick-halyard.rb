class PickHalyard < Formula
  desc "Command line arg picker"
  homepage "https://github.com/thoughtbot/pick"
  url "https://github.com/thoughtbot/pick/releases/download/v3.0.0/pick-3.0.0.tar.gz"
  sha256 "2783b9c11b54301ce32c0c2e70cf4dc8d437cb68cf136ba204a6065422055298"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pick", "-v"
  end
end
