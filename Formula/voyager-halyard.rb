class VoyagerHalyard < Formula
  desc "Helper for connecting to AWS accounts"
  homepage "https://github.com/akerl/voyager"

  version "0.4.5"
  url "https://github.com/akerl/voyager/releases/download/#{version}/voyager_darwin"
  sha256 "36a44ecd905194ab0d5d96f0cffd56894ab1c8a7b29a7ac322c3c6b803feabb4"

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
