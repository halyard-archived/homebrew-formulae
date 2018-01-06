class EtcherHalyard < Formula
  desc "Etcher"
  homepage "https://etcher.io/cli/"
  version "1.3.0"
  url "https://github.com/resin-io/etcher/releases/download/v#{version}/Etcher-cli-#{version}-darwin-x64.tar.gz"
  sha256 "07ec2c25070a1c9f32eeb95e478c35bc27c7ed7e728cada25e92113baaa17709"

  def install
    bin.install "etcher"
    bin.install "node_modules"
  end

  test do
    system "#{bin}/etcher -v"
  end
end
