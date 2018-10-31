class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  url "https://github.com/resin-io/etcher/releases/download/v1.4.6/etcher-cli-1.4.6-darwin-x64.tar.gz"
  version "1.4.6"
  sha256 "37e78f02c667d01813f17a0321bbd9d60d78bbb1a2e0dfd5df00f586dd6cc715"

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/etcher"]
  end

  test do
    system "#{bin}/etcher -v"
  end
end
