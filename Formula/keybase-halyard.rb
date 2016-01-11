class KeybaseHalyard < Formula
  desc 'Keybase'
  homepage 'https://keybase.io/'

  version '1.0.6-0'
  url "https://github.com/keybase/client/archive/v#{version}.tar.gz"
  sha256 '6942ac5ba511bf0411607e5c2292965bbc2fb2942f4bf2a1c8e79f25cd966676'
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
