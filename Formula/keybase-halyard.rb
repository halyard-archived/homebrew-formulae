class KeybaseHalyard < Formula
  desc 'Keybase'
  homepage 'https://keybase.io/'

  version '1.0.9-0'
  url "https://github.com/keybase/client/archive/v#{version}.tar.gz"
  sha256 '01999048454877bc3b6a2934a8c1bfda4ebef31400698627a23b94450d5b2409'
  head 'https://github.com/keybase/client.git'

  depends_on 'go' => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"
    (buildpath/"src/github.com/keybase/client/").install "go"

    system "go", "build", "-a", "-tags", "production brew", "github.com/keybase/client/go/keybase"

    bin.install "keybase"
  end

  test do
    system "#{bin}/keybase", "-standalone", "id", "homebrew"
  end
end
