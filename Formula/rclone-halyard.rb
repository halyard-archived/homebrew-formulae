require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.32'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 'd00c9de15850997953fbaba5b5c8fe1be8ecfd8ac8c332e5078d00119ab44c5f'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
