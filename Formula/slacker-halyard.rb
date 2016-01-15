class SlackerHalyard < Formula
  desc 'MAC to EUI64 converter'
  homepage 'https://github.com/akerl/slacker'

  version '0.0.2'
  url "https://github.com/akerl/slacker/archive/#{version}.tar.gz"
  sha256 '24a375fc25276a9a31ecc33e7f1bc3b093faf7f2e7d539765f5c2fbb80ce0e90'
  head 'https://github.com/akerl/slacker.git'

  depends_on 'go' => :build

  def install
    ENV['GOPATH'] = buildpath
    ENV['GOBIN'] = buildpath
    system 'go', 'build', '-o', 'slacker'
    bin.install 'slacker'
  end
end
