class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  version "0.0.2"
  url "https://github.com/akerl/speculate/releases/download/v#{version}/speculate_darwin"
  sha256 "cd0d3f323c1e0f53271bc7ef2a8f5df70c9b440a0638adb72f998df4502a0a36"

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
