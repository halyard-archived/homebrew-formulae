class KeybaseHalyard < Formula
  desc 'Keybase'
  homepage 'https://keybase.io/'

  version '1.0.17'
  url "https://github.com/keybase/client/archive/v#{version}.tar.gz"
  sha256 '937b4bc61c889ef3982a5352d8a49cda8a4f4db28732d4cb21df1fe20128399c'
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
