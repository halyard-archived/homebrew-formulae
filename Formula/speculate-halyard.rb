class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  version "0.0.3"
  url "https://github.com/akerl/speculate/releases/download/v#{version}/speculate_darwin"
  sha256 "ae9cde0c676eda435cc3dbd1762212f6cc8005e45f9a1b689fa77c60c28d1cdb"

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
