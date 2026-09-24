# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class TgAlpha < Formula
  desc "Agent for tiefgang.sh self-hosted runners (alpha channel)"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.10/SHA256SUMS"
  version "0.1.1-alpha.10"
  sha256 "5868849c0d40a056c9b3a5164bbd3b65adfae79c670b0c15f7f2258bb52595ef"

  on_macos do
    depends_on arch: :arm64
  end

  conflicts_with "tg", because: "both install bin/tg"

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.10/tg_0.1.1-alpha.10_darwin_arm64.tar.gz"
      sha256 "49f637983be5bbcce834b4f0552380fb1ea29de05a2988a2fdea636770e78646"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.10/tg_0.1.1-alpha.10_linux_arm64.tar.gz"
        sha256 "9d26b04263798d3ed59e80d2deeb724b5af545f9c8f6d248666c9d38dfe18238"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.10/tg_0.1.1-alpha.10_linux_amd64.tar.gz"
        sha256 "8417c1b3fcfe2b047b99983f911b029f6e327647f7783ef86d36b648b34f5a0a"
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
