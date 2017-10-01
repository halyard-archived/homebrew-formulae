class RcloneHalyard < Formula
  desc "File syncing tool"
  homepage "http://rclone.org"
  version "1.38"
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 "9c60f7404859eb49ea17d4a424ede273bfd63abe7c1ba5e51a1cb74017ccf613"

  def install
    bin.install "rclone"
    man1.install "rclone.1"
  end

  test do
    system bin/"rclone", "--version"
  end
end
