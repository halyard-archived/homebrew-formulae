class VoyagerHalyard < Formula
  desc "Helper for connecting to AWS accounts"
  homepage "https://github.com/akerl/voyager"

  version "0.5.0"
  url "https://github.com/akerl/voyager/releases/download/#{version}/voyager_darwin"
  sha256 "4f3fc15b7114e8c4589407284b9b28d0bdd7143499f707fe298bb331bbdaa49a"

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
