class RcloneHalyard < Formula
  desc "File syncing tool"
  homepage "http://rclone.org"
  version "1.34"
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 "aad4869ecb7db3135260726bdf2362d20db86adde12cc42bede80014979d8381"

  def install
    bin.install "rclone"
    man1.install "rclone.1"
  end

  test do
    system bin/"rclone", "--version"
  end
end
