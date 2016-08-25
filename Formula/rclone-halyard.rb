require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.33'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 '71e6051a46cf72715a77f6534a6ca6e1a6dcaf1c33132720e806d84e35f1c60b'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
