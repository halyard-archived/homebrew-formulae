require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.30'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 '2ea7bfb18448d2a81593abf128c034270c21e62c615b79c143743e7e07919ce0'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
