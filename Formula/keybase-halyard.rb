class KeybaseHalyard < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client/archive/v1.0.29.tar.gz"
  sha256 "4790a3b3a50e0718bfcf8ebce159c6c4598740ea9f924fffc566003709ca79e7"
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
