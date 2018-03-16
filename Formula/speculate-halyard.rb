class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  version "0.3.5"
  url "https://github.com/akerl/speculate/releases/download/#{version}/speculate_darwin"
  sha256 "b55cb05f5fffeaf1c0713d44ae8c3bd12dd9ca2e29e30ff9966dcc3e91057a78"

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
