# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class TgAlpha < Formula
  desc "Agent for tiefgang.sh self-hosted runners (alpha channel)"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.3/SHA256SUMS"
  version "0.1.2-alpha.3"
  sha256 "de15494ac4df69b58c252b0063244e1abf5b113539dc8fb066b2379f357928e5"

  on_macos do
    depends_on arch: :arm64
  end

  conflicts_with "tg", because: "both install bin/tg"

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.3/tg_0.1.2-alpha.3_darwin_arm64.tar.gz"
      sha256 "1c653641e7f9b1b56c9814e3ba91f0f926f26355954957382f99388243d9b8d4"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.3/tg_0.1.2-alpha.3_linux_arm64.tar.gz"
        sha256 "5e21d089e813ef12c3ad2d9495b0b84c31677f2469b71713402db024448c10bc"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.3/tg_0.1.2-alpha.3_linux_amd64.tar.gz"
        sha256 "58f706ce540d89b4cc8bc551ec2657640ce11f07c681b1eaaea6a9102f065bed"
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
