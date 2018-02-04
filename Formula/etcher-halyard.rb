class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  version "1.3.1"
  url "https://github.com/resin-io/etcher/releases/download/v#{version}/Etcher-cli-#{version}-darwin-x64.tar.gz"
  sha256 "6e862e2d2e64c264fb90ec409d82b43c1719453f5ed1cff18aa31b2d890ac6c7"

  def install
    bin.install "etcher"
    bin.install "node_modules"
  end

  test do
    system "#{bin}/etcher -v"
  end
end
