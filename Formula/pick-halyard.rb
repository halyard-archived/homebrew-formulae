class PickHalyard < Formula
  desc "Command line arg picker"
  homepage "https://github.com/thoughtbot/pick"
  version = "1.6.1"
  url "https://github.com/thoughtbot/pick/releases/download/v#{version}/pick-#{version}.tar.gz"
  sha256 "b2d0384c376b697b7e8f17843485e6373514f001b35be18b6414a2fd5ced8d9b"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pick", "-v"
  end
end
