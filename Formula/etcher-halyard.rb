class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  url "https://github.com/balena-io/etcher/releases/download/v1.4.8/balena-etcher-cli-1.4.8-darwin-x64.tar.gz"
  version "1.4.8"
  sha256 "8eab1d283666c05c230308a59319ed76709fbce3b19e0ea1970a4a6f1ff13a7d"

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/etcher"]
  end

  test do
    system "#{bin}/etcher -v"
  end
end
