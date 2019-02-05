class MadlibrarianHalyard < Formula
  desc "Generate quotes from template files"
  homepage "https://github.com/akerl/madlibrarian"

  url "https://github.com/akerl/madlibrarian/releases/download/v0.1.0/madlibrarian_darwin"
  version "0.1.0"
  sha256 "7c5af6a7d335b82e77190cc9b1bbb4717b16624412aa82b0955e2d382b3fb3b2"

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
