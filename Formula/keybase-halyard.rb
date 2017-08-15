class KeybaseHalyard < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client/archive/v1.0.27.tar.gz"
  sha256 "1ebce1966d0cf1728096394191a9e0fab00bf64d9fa4a5a3718ecd3d789df8f8"
  head "https://github.com/keybase/client.git"

  depends_on "go" => :build

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
