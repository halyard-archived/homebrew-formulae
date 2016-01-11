require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.26'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 '1cf0422484cf931191e2babf60dfa55aaa2d001f97bf3039b2eb051a736e1d90'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
