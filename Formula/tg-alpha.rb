# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class TgAlpha < Formula
  desc "Agent for tiefgang.sh self-hosted runners (alpha channel)"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.7/SHA256SUMS"
  version "0.1.2-alpha.7"
  sha256 "6d932842bbb3d74cf03508c3e7c07f6c93c9e0ca30a9545c8f6e7db574278955"

  on_macos do
    depends_on arch: :arm64
  end

  conflicts_with "tg", because: "both install bin/tg"

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.7/tg_0.1.2-alpha.7_darwin_arm64.tar.gz"
      sha256 "e5e783b1c3a581a4166e16e49b89d2b8b830ffa71812c99321b0123ea02fb98e"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.7/tg_0.1.2-alpha.7_linux_arm64.tar.gz"
        sha256 "4f72976fbd7a44440ff0b8d23466c4efd99bcb96cc990a5ec17ab646c6b3bd25"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2-alpha.7/tg_0.1.2-alpha.7_linux_amd64.tar.gz"
        sha256 "b91571a7258d5283989a9ddcb58331f9109004fd0851e3cf22abc6d5f56b32c2"
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
