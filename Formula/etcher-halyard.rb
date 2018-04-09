class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  version "1.4.0"
  url "https://github.com/resin-io/etcher/releases/download/v#{version}/Etcher-cli-#{version}-darwin-x64.tar.gz"
  sha256 "30256ec537cabe640a000e1b508359f6884786f43b42b5353941ec733a683964"

  def install
    bin.install "etcher"
    bin.install "node_modules"
  end

  test do
    system "#{bin}/etcher -v"
  end
end
