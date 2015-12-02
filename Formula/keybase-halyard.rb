class KeybaseHalyard < Formula
  desc 'Keybase'
  homepage 'https://keybase.io/'

  version '1.0.5-0'
  url "https://github.com/keybase/client/archive/v#{version}.tar.gz"
  sha256 'fcc41dbe3c602c33dd5853fd81ab66baa91c2cc0524ed5bdf89456f2df143e8a'
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
