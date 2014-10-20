require 'formula'

class FlintHalyard < Formula
  homepage 'https://github.com/pengwynn/flint'
  url "https://github.com/pengwynn/flint/releases/download/v#{version}/flint_darwin_amd64"
  sha256 '349e1289bb51488199acd5ba1c6ff9960d05fe10f2e3f64253b534bf55c7fd64'
  version '0.0.3'

  def install
    system 'mv flint_darwin_amd64 flint'
    bin.install 'flint'
  end
end
