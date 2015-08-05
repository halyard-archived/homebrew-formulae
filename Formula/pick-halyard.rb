require "formula"

class PickHalyard < Formula
  homepage 'http://thoughtbot.github.io/pick/'
  version '1.1.1'
  url "https://github.com/thoughtbot/pick/releases/download/v#{version}/pick-#{version}.tar.gz"
  sha256 '2d2707d9fb6d9f8b3afffc0f02f81e7b6a02cf7823127e10b1c952adee42a306'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make', 'install'
  end

  test do
    system "#{bin}/pick", '-v'
  end
end
