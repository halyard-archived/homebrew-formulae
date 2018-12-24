class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  url "https://github.com/balena-io/etcher/releases/download/v1.4.9/balena-etcher-cli-1.4.9-darwin-x64.tar.gz"
  version "1.4.9"
  sha256 "0720a0bd021b7a7f686d99a90b916a37948eccbe5394ba0e24d1d96fcec843eb"

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/etcher"]
  end

  test do
    system "#{bin}/etcher -v"
  end
end
