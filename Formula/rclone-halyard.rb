require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.28'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 'e8c878ae7e4c36145b6c848b0973baa8da59152195b0670142b4471f5f2614a9'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
