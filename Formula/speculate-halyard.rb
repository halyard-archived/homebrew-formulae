class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  version "0.1.5"
  url "https://github.com/akerl/speculate/releases/download/#{version}/speculate_darwin"
  sha256 "f3e4f8a29ebf301feab18ca8c3cf68f2e92d077c64e97b1ae3c7b07f11b4816a"

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
