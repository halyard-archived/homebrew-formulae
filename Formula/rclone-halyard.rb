class RcloneHalyard < Formula
  desc "File syncing tool"
  homepage "http://rclone.org"
  version "1.39"
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 "58580f32325bc373687f87d8ba91c39ca12de3ce409fbfb32cf6a6173cd8c0e3"

  def install
    bin.install "rclone"
    man1.install "rclone.1"
  end

  test do
    system bin/"rclone", "--version"
  end
end
