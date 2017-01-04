class RcloneHalyard < Formula
  desc "File syncing tool"
  homepage "http://rclone.org"
  version "1.35"
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 "92c9db21f252b971c0b2e361248449aa3a14200e186efc51eef28938b4adfa90"

  def install
    bin.install "rclone"
    man1.install "rclone.1"
  end

  test do
    system bin/"rclone", "--version"
  end
end
