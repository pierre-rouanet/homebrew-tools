class Duckctl < Formula
  desc "Talk to a Microduck robot from a laptop over Bluetooth LE"
  homepage "https://github.com/pollen-robotics/microduck"
  version "0.17.3"
  license "Apache-2.0"

  # PyPI gets each stable `daemon-vX.Y.Z` release, so the latest release names the version.
  livecheck do
    url :homepage
    regex(/^daemon-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  uses_from_macos "unzip" => :build

  # The binary CI builds for each release, taken out of the PyPI wheel it ships in.
  on_macos do
    on_arm do
      url "https://files.pythonhosted.org/packages/e6/a8/e8aa90f7a26a2647e414e24372aef3f01f749c182a678c511eb3bfa78f5e/duckctl-0.17.3-py3-none-macosx_11_0_arm64.whl",
          using: :nounzip
      sha256 "fbe9c673168e82416ea60f8660bd3e632983cf2e72e9bae3aff378274d5aa224"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/df/af/5660ddfaf5464c3138592f0bfa72c2021a247dc4cb5abd7224d049c5f152/duckctl-0.17.3-py3-none-macosx_10_12_x86_64.whl",
          using: :nounzip
      sha256 "d7349f97d156f88f2fbf9ae7b2d10888068d72bd7ad4228ef03dc0229f83383a"
    end
  end

  on_linux do
    on_arm do
      url "https://files.pythonhosted.org/packages/71/8d/65cf4c57dc3366cd7383fbb998a5255b267e38cb8ffaa8f2850321324483/duckctl-0.17.3-py3-none-manylinux_2_28_aarch64.whl",
          using: :nounzip
      sha256 "12307e6736ba28a67e46149aa1ff0cf6ef10baa90487052125f417fd98f3d590"
    end
    on_intel do
      url "https://files.pythonhosted.org/packages/c9/1d/aa3c2a7b741af2deb6b0f1ab61d07b68a326a652d528c7614c5c0460a0b0/duckctl-0.17.3-py3-none-manylinux_2_28_x86_64.whl",
          using: :nounzip
      sha256 "4589c83a1e1930c843f4b36a7c2687caa72484b1300b9011a6632ac94c2ab6e2"
    end
  end

  def install
    system "unzip", "-q", Dir["*.whl"].first
    bin.install "duckctl-#{version}.data/scripts/duckctl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/duckctl --version")
  end
end
