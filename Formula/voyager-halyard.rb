class VoyagerHalyard < Formula
  desc "Helper for connecting to AWS accounts"
  homepage "https://github.com/akerl/voyager"

  version "0.2.0"
  url "https://github.com/akerl/voyager/releases/download/#{version}/voyager_darwin"
  sha256 "07d2986bb9fecb55405fd01b0025f371dba7f96b3950ab46cc316399df2d0971"

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
