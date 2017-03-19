class RcloneHalyard < Formula
  desc "File syncing tool"
  homepage "http://rclone.org"
  version "1.36"
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 "3ec7d5658258ad99480ed7b07d552fe4d5d01677fe765f890e0cc1ed08c82b26"

  def install
    bin.install "rclone"
    man1.install "rclone.1"
  end

  test do
    system bin/"rclone", "--version"
  end
end
