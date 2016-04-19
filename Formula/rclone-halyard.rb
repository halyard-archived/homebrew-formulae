require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.29'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 '64c95564ae69f5238000c6adb2f4d178923176ecfd9d64cddfd80bfa538e1c15'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
