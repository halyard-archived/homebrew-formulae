require "formula"

class PickHalyard < Formula
  homepage 'https://github.com/thoughtbot/pick'
  version '1.2.0'
  url "https://github.com/thoughtbot/pick/releases/download/v#{version}/pick-#{version}.tar.gz"
  sha256 'c7593f5dde7d13177f1258b941d635761b4ea38e4c991aa7916ce4e3f581e090'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make', 'install'
  end

  test do
    system "#{bin}/pick", '-v'
  end
end
