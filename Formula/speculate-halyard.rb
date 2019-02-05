class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  url "https://github.com/akerl/speculate/releases/download/v0.10.2/speculate_darwin"
  version "0.10.2"
  sha256 "0d5bf40de13c232a788eb231b60ade72b53c6bd89255da6b38368c4b85f0d5d7"

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
