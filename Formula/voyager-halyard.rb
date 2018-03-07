class VoyagerHalyard < Formula
  desc "Helper for connecting to AWS accounts"
  homepage "https://github.com/akerl/voyager"

  version "0.3.1"
  url "https://github.com/akerl/voyager/releases/download/#{version}/voyager_darwin"
  sha256 "8fea5c30757acf04dc8e08ea6cc2f8dc161ec2357c30b0826e3bfbc1687a4a04"

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
