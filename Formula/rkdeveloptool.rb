class Rkdeveloptool < Formula
  desc "Flash Rockchip devices over USB in maskrom or loader mode"
  homepage "https://github.com/rockchip-linux/rkdeveloptool"
  url "https://github.com/rockchip-linux/rkdeveloptool.git",
      revision: "304f073752fd25c854e1bcf05d8e7f925b1f4e14"
  version "1.32"
  license "GPL-2.0-only"
  head "https://github.com/rockchip-linux/rkdeveloptool.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "libusb"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make"
    bin.install "rkdeveloptool"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rkdeveloptool -v")
  end
end
