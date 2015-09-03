require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.19'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 'c50863565b898250a19e73038a3b4650cfb91342204c3b030ad06e92f1a54581'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
