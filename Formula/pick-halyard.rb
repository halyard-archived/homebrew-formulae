class PickHalyard < Formula
  desc "Command line arg picker"
  homepage "https://github.com/thoughtbot/pick"
  url "https://github.com/thoughtbot/pick/releases/download/v1.4.0/pick-1.4.0.tar.gz"
  sha256 "46f46b0df54cf27e8dd19ae291d5534cb55ef37d9cdb3cc774cd88c809f718fd"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pick", "-v"
  end
end
