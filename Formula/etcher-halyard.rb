class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  version "1.2.1"
  url "https://github.com/resin-io/etcher/releases/download/v#{version}/Etcher-cli-#{version}-darwin-x64.tar.gz"
  sha256 "18c20ace231bdb0b954d89946a98de25c869c918e7399e7fb7133486dd0eff55"

  def install
    bin.install "etcher"
    bin.install "node_modules"
  end

  test do
    system "#{bin}/etcher -v"
  end
end
