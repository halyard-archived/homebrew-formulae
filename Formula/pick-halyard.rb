class PickHalyard < Formula
  desc "Command line arg picker"
  homepage "https://github.com/thoughtbot/pick"
  _version = "1.5.2"
  url "https://github.com/thoughtbot/pick/releases/download/v#{_version}/pick-#{_version}.tar.gz"
  sha256 "183b278981233c70ac7f4d9af0728bf99d9d237e3f88d979f93fcc5968c2f789"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pick", "-v"
  end
end
