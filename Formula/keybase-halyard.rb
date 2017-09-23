class KeybaseHalyard < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client/archive/v1.0.31.tar.gz"
  sha256 "684c07e68c0daf8f3387fc2276c80ef6b5532cf603f4eaa2db6f8394c084f92c"
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
