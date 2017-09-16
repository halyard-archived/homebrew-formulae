class KeybaseHalyard < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client/archive/v1.0.30.tar.gz"
  sha256 "a94cd36567ee49bfda275677b816ebb0ea8c44e391666880d3ef310d456be0e1"
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
