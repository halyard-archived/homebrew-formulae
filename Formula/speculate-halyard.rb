class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  version "0.1.0"
  url "https://github.com/akerl/speculate/releases/download/#{version}/speculate_darwin"
  sha256 "199d288e2a886d06c075c1c34777e737ee78c0259a4141dc08d9e74fd1c99304"

  head do
    url "https://github.com/akerl/speculate.git"
    depends_on "go" => :build
  end

  def install
    if build.head?
      system "make"
      mv "bin/speculate_darwin", "speculate"
    else
      mv "speculate_darwin", "speculate"
    end
    bin.install "speculate"
  end

  test do
    system bin/"speculate", "version"
  end
end
