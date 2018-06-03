class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  url "https://github.com/resin-io/etcher/releases/download/v1.4.4/etcher-cli-1.4.4-darwin-x64.tar.gz"
  version "1.4.4"
  sha256 "889de471078f2ceb213cb3b83a3ea9edf1c96c193e53e500eb3487e33d591131"

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/etcher"]
  end

  test do
    system "#{bin}/etcher -v"
  end
end
