class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  version "0.3.0"
  url "https://github.com/akerl/speculate/releases/download/#{version}/speculate_darwin"
  sha256 "fee9647e2c129014039efa3f4c4e0be128ee54dd47288a8f2e44e5dec9b1c41c"

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
