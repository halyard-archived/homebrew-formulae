class MadlibrarianHalyard < Formula
  desc "Generate quotes from template files"
  homepage "https://github.com/akerl/madlibrarian"

  version "0.0.1"
  url "https://github.com/akerl/madlibrarian/releases/download/#{version}/madlibrarian_darwin"
  sha256 "6521c1c6e0ddc986200847ad549e90e2653f3b8f742d1327547c4209ccab7b2f"

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
