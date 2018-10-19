class VoyagerHalyard < Formula
  desc "Helper for connecting to AWS accounts"
  homepage "https://github.com/akerl/voyager"

  url "https://github.com/akerl/voyager/releases/download/0.6.0/voyager_darwin"
  version "0.6.0"
  sha256 "399b46e0445f22507d121edc5815393831e2e0e85658deeedee20a7340f998f9"

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
