class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  version "1.4.3"
  url "https://github.com/resin-io/etcher/releases/download/v#{version}/etcher-cli-#{version}-darwin-x64.tar.gz"
  sha256 "30f6b0836dec886a51deb5b0ee31ef0df505236113eb36c036016100492809db"

  def install
    bin.install "etcher"
    bin.install "node_modules"
  end

  test do
    system "#{bin}/etcher -v"
  end
end
