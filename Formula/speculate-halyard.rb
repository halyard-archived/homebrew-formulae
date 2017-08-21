class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  version "0.0.10"
  url "https://github.com/akerl/speculate/releases/download/#{version}/speculate_darwin"
  sha256 "99776a481ef5e442c9c579b0128cf5f75fb6b577e97abc49e3420e1f586fae0c"

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
