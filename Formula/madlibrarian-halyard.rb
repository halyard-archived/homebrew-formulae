class MadlibrarianHalyard < Formula
  desc "Generate quotes from template files"
  homepage "https://github.com/akerl/madlibrarian"

  url "https://github.com/akerl/madlibrarian/releases/download/0.0.4/madlibrarian_darwin"
  version "0.0.4"
  sha256 "1e8781f28fa571a609009684c6968c099dd882e9b4832f0c1fcea81d81243972"

  head do
    url "https://github.com/akerl/madlibrarian.git"
    depends_on "go" => :build
  end

  def install
    if build.head?
      system "make"
      mv "bin/madlibrarian_darwin", "madlibrarian"
    else
      mv "madlibrarian_darwin", "madlibrarian"
    end
    bin.install "madlibrarian"
  end

  test do
    system bin/"madlibrarian", "version"
  end
end
