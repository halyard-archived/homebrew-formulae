class MadlibrarianHalyard < Formula
  desc "Generate quotes from template files"
  homepage "https://github.com/akerl/madlibrarian"

  version "0.0.3"
  url "https://github.com/akerl/madlibrarian/releases/download/#{version}/madlibrarian_darwin"
  sha256 "17f6f55056dc423514cdd472bcf18cb83dcc4db1d5ada0b5a5520806df160c3d"

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
