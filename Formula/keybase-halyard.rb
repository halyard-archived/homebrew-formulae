class KeybaseHalyard < Formula
  desc 'Keybase'
  homepage 'https://keybase.io/'

  version '1.0.0-25'
  url "https://github.com/keybase/client-beta/archive/v#{version}.tar.gz"
  sha256 '47f29fbce993dcacbfa790476699d8946bded97e2053310744dfff36475f1cba'
  head 'https://github.com/keybase/client-beta.git'

  depends_on 'go' => :build

  def install
    inreplace 'client/go/libkb/constants_release.go', '//const', 'const'

    ENV['GOPATH'] = buildpath
    ENV['GOBIN'] = buildpath
    system 'mkdir', '-p', 'src/github.com/keybase/'
    system 'mv', 'client', 'src/github.com/keybase/'

    system 'go', 'get', 'github.com/keybase/client/go/keybase'
    system 'go', 'build', '-a', '-tags', 'release brew', '-o', 'keybase', 'github.com/keybase/client/go/keybase'

    bin.install 'keybase'
  end
end
