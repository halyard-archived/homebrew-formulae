require 'formula'

class FlintHalyard < Formula
  homepage 'https://github.com/pengwynn/flint'
  version '0.0.4'
  url "https://github.com/pengwynn/flint/releases/download/v#{version}/flint_darwin_amd64.zip"
  sha256 'a872d3426bbab7618a25de0793f864fa2050c7de34bdec8a4c8a8967ad8ede6d'

  def install
    system 'mv flint_darwin_amd64 flint'
    bin.install 'flint'
  end
end
