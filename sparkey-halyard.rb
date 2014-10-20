require 'formula'

class SparkeyHalyard < Formula
  homepage 'https://github.com/spotify/sparkey'
  url 'https://github.com/spotify/sparkey.git'
  version '0.2.0'

  depends_on 'snappy' => :build

  def install
    system 'autoreconf --install'
    system "./configure --prefix=#{prefix}"
    system 'make'
    system 'make install'
  end
end
