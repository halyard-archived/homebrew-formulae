class RcloneHalyard < Formula
  desc "Rsync for cloud storage"
  homepage "https://rclone.org/"
  url "https://github.com/ncw/rclone/archive/v1.45.tar.gz"
  sha256 "7cfe20990fa88be5a3883e2d8059e67244032a7db46414370643eecb86fe1b58"
  head "https://github.com/ncw/rclone.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/ncw/"
    ln_s buildpath, buildpath/"src/github.com/ncw/rclone"
    system "go", "build", "-o", bin/"rclone"
    man1.install "rclone.1"
    system bin/"rclone", "genautocomplete", "bash", "rclone.bash"
    system bin/"rclone", "genautocomplete", "zsh", "_rclone"
    bash_completion.install "rclone.bash" => "rclone"
    zsh_completion.install "_rclone"
  end

  test do
    (testpath/"file1.txt").write "Test!"
    system "#{bin}/rclone", "copy", testpath/"file1.txt", testpath/"dist"
    assert_match File.read(testpath/"file1.txt"), File.read(testpath/"dist/file1.txt")
  end
end
