class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  version "0.3.4"
  url "https://github.com/akerl/speculate/releases/download/#{version}/speculate_darwin"
  sha256 "5abff095e95b0dc9873cc3254e459f1f6b91ab7653da38062c3b93dc4e499c19"

  head do
    url "https://github.com/akerl/speculate.git"
    depends_on "go" => :build
  end

  def install
    if build.head?
      system "make"
      mv "bin/speculate_darwin", "speculate"
    else
      mv "speculate_darwin", "speculate"
    end
    bin.install "speculate"
  end

  test do
    system bin/"speculate", "version"
  end
end
