class VoyagerHalyard < Formula
  desc "Helper for connecting to AWS accounts"
  homepage "https://github.com/akerl/voyager"

  version "0.0.2"
  url "https://github.com/akerl/voyager/releases/download/#{version}/voyager_darwin"
  sha256 "26a9960304268b410f7b29267ba0a4d2850c07b4839bdb7258fb3ea1cc25f113"

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
