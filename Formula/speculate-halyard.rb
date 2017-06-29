class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  version "0.0.5"
  url "https://github.com/akerl/speculate/releases/download/v#{version}/speculate_darwin"
  sha256 "a85e95c4c5b9a1fc832166abd60682d153d573069268331ed0da0cadbf968e17"

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
