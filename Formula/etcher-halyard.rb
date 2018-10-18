class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  url "https://github.com/resin-io/etcher/releases/download/v1.4.5/etcher-cli-1.4.5-darwin-x64.tar.gz"
  version "1.4.5"
  sha256 "39624e9b599b241807186f3efac82ba86c9add8b63edba1e5ac51c73849d778b"

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/etcher"]
  end

  test do
    system "#{bin}/etcher -v"
  end
end
