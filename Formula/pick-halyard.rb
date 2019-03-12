class PickHalyard < Formula
  desc "Command line arg picker"
  homepage "https://github.com/thoughtbot/pick"
  url "https://github.com/thoughtbot/pick/releases/download/v3.0.1/pick-3.0.1.tar.gz"
  sha256 "668c863751f94ad90e295cf861a80b4d94975e06645f401d7f82525e607c0266"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pick", "-v"
  end
end
