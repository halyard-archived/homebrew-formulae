class VoyagerHalyard < Formula
  desc "Helper for connecting to AWS accounts"
  homepage "https://github.com/akerl/voyager"

  version "0.4.6"
  url "https://github.com/akerl/voyager/releases/download/#{version}/voyager_darwin"
  sha256 "9699b7c38c800e69644d6054cc21d244bdc6cd4f6682c97e593d0b01e0891fae"

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
