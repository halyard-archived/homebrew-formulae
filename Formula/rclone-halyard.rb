require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.27'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 '7de9e938496ce4eed5046de864152c3da05e6d11a154a2d6ded4e6ddedc00b2a'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
