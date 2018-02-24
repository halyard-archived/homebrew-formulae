class VoyagerHalyard < Formula
  desc "Helper for connecting to AWS accounts"
  homepage "https://github.com/akerl/voyager"

  version "0.1.1"
  url "https://github.com/akerl/voyager/releases/download/#{version}/voyager_darwin"
  sha256 "da8d6e42fa134d391031dd3a945d8f3d8eb93de2fc757b4f2c28462a6b71a348"

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
