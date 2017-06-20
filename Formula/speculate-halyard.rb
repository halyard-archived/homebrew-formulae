class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  version "0.0.4"
  url "https://github.com/akerl/speculate/releases/download/v#{version}/speculate_darwin"
  sha256 "0c440ed693e3a3c96440953816424137cd499d5d4ce60cde49d0bf9771cbf6c4"

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
