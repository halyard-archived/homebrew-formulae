require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.31'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 'daf085731ff175f3376bbf505a470c0a099b8cb3b8fb765946de8f9ada8fbd44'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
