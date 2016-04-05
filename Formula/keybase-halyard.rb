class KeybaseHalyard < Formula
  desc 'Keybase'
  homepage 'https://keybase.io/'

  version '1.0.15'
  url "https://github.com/keybase/client/archive/v#{version}.tar.gz"
  sha256 '6fe66b07772ca000879bda65cb9d112d2dbbc301d6afa4d4b46055d385f86e36'
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
