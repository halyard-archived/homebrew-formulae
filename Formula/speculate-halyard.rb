class SpeculateHalyard < Formula
  desc "Tool for assuming roles in AWS accounts"
  homepage "https://github.com/akerl/speculate"

  url "https://github.com/akerl/speculate/releases/download/v0.0.1/speculate_darwin"
  sha256 "883fbbd4401702f798af6716889f1fc1450a9860208413aaa019a5567cf806d9"
  
  head do
    url "https://github.com/akerl/speculate.git"
    depends_on "go" => :build
  end

  def install
    if build.head?
      system 'make'
      mv 'bin/speculate_darwin', 'speculate'
    else
      mv 'speculate_darwin', 'speculate'
    end
    bin.install "speculate"
  end

  test do
    system bin/"speculate", "version"
  end
end
