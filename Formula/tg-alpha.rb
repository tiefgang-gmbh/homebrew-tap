# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class TgAlpha < Formula
  desc "Agent for tiefgang.sh self-hosted runners (alpha channel)"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.2/SHA256SUMS"
  version "0.1.2-alpha.2"
  sha256 "12e4e6a0269ebcb7729b8151622e49cdb8f8de578a6c1d389b6b511344dbee72"

  on_macos do
    depends_on arch: :arm64
  end

  conflicts_with "tg", because: "both install bin/tg"

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.2/tg_0.1.2-alpha.2_darwin_arm64.tar.gz"
      sha256 "1082366a102c18030ab9bdb067adf392b91a1b2ece2b2214825260a7d60723fd"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.2/tg_0.1.2-alpha.2_linux_arm64.tar.gz"
        sha256 "ca711a78ff906998ddd74f1d83857b690c03e9b865ceb736541e34dce8eaf48a"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.2/tg_0.1.2-alpha.2_linux_amd64.tar.gz"
        sha256 "65f5229249e3a73323537b4133abf56e7f0b7e0e0606af4e8df61d7a2e9f239c"
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
