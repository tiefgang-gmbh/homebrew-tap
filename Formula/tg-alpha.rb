# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class TgAlpha < Formula
  desc "Agent for tiefgang.sh self-hosted runners (alpha channel)"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.11/SHA256SUMS"
  version "0.1.1-alpha.11"
  sha256 "09055d70808b6c63d18c504341390c53e4d759e44d732e6175f3f3d94bd159ae"

  on_macos do
    depends_on arch: :arm64
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.11/tg_0.1.1-alpha.11_darwin_arm64.tar.gz"
      sha256 "b5c0426ead0939d61f2a9521b17c4f18e515ec2fd9cd1c3d6e36f608c6a30f42"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.11/tg_0.1.1-alpha.11_linux_arm64.tar.gz"
        sha256 "aa28d756f9dac90b7450be408de3c949a184063b03756fa97600317fec5e8a39"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.11/tg_0.1.1-alpha.11_linux_amd64.tar.gz"
        sha256 "90ec226a1d428e2713b3a2ce3f3b2f647f21b486404323a7a175b3379dff3583"
      end
    end
  end

  def install
    resource("tarball").stage { bin.install "tg" }
  end

  def caveats
    <<~EOS
      The formula installs no service. To run the agent as a daemon (root is required):
        sudo #{HOMEBREW_PREFIX}/bin/tg service install --channel alpha
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tg version")
  end
end
