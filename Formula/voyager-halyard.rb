class VoyagerHalyard < Formula
  desc "Helper for connecting to AWS accounts"
  homepage "https://github.com/akerl/voyager"

  version "0.0.1"
  url "https://github.com/akerl/voyager/releases/download/v#{version}/voyager_darwin"
  sha256 "26c17b0e97860702afe32b3c8aece68337b5da629bf1083f386fe2693dd7f5c0"

  head do
    url "https://github.com/akerl/voyager.git"
    depends_on "go" => :build
  end

  def install
    if build.head?
      system "make"
      mv "bin/voyager_darwin", "voyager"
    else
      mv "voyager_darwin", "voyager"
    end
    bin.install "voyager"
  end

  test do
    system bin/"voyager", "version"
  end
end
