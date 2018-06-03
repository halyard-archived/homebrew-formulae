class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  url "https://github.com/akerl/speculate/releases/download/0.4.0/speculate_darwin"
  version "0.4.0"
  sha256 "7d1c07cde64c97c23734653c836d3a2299340829394217e439e390c8459d7ace"

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
