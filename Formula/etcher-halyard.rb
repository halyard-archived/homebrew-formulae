class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  version "1.4.4"
  url "https://github.com/resin-io/etcher/releases/download/v#{version}/etcher-cli-#{version}-darwin-x64.tar.gz"
  sha256 "889de471078f2ceb213cb3b83a3ea9edf1c96c193e53e500eb3487e33d591131"

  def install
    bin.install "etcher"
    bin.install "node_modules"
  end

  test do
    system "#{bin}/etcher -v"
  end
end
