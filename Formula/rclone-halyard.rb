class RcloneHalyard < Formula
  desc "File syncing tool"
  homepage "http://rclone.org"
  version "1.37"
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 "0eb39c4774a3c90f21ba5ac67bc2684e0ac8cf1a625ae4a92d981a2c842f8d99"

  def install
    bin.install "rclone"
    man1.install "rclone.1"
  end

  test do
    system bin/"rclone", "--version"
  end
end
