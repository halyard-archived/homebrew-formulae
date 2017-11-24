class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  version "1.2.0"
  url "https://github.com/resin-io/etcher/releases/download/v#{version}/Etcher-cli-#{version}-darwin-x64.tar.gz"
  sha256 "40957424f3381abe6f0c421dbad5666be74af219ac0af968c74fc22fb7a2a528"

  def install
    bin.install "etcher"
    bin.install "node_modules"
  end

  test do
    system "#{bin}/etcher -v"
  end
end
