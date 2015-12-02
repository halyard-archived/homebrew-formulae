require "formula"

class PickHalyard < Formula
  homepage 'https://github.com/thoughtbot/pick'
  version '1.2.1'
  url "https://github.com/thoughtbot/pick/releases/download/v#{version}/pick-#{version}.tar.gz"
  sha256 '048fe3733460cc284ddda1edada80b819b66f331bc0a88f489637b9e3a500700'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make', 'install'
  end

  test do
    system "#{bin}/pick", '-v'
  end
end
