require 'formula'

class RcloneHalyard < Formula
  homepage 'http://rclone.org'
  version '1.18'
  url "http://downloads.rclone.org/rclone-v#{version}-osx-amd64.zip"
  sha256 '4afece9fb4c2b9aef49497dd91c1f4eed6ea175cfb5d7ac5247251e1631f26c5'

  def install
    bin.install 'rclone'
    man1.install 'rclone.1'
  end
end
