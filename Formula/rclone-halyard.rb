require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.25'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 'c7078a4e288e8ed2558b39439056fdceea80efccbd31e42043505644a18c943b'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
