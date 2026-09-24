# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1/SHA256SUMS"
  sha256 "79f230339d28449ef243de4983d7c9792828d05e765a178f54082937ad516d5f"

  on_macos do
    depends_on arch: :arm64
  end

  conflicts_with "tg-alpha", because: "both install bin/tg"

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1/tg_0.1.1_darwin_arm64.tar.gz"
      sha256 "8c61094ad885c26220c9d0d1ed3b5e3e3d0a846fcb39dad2fd3c410f9dff83ab"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1/tg_0.1.1_linux_arm64.tar.gz"
        sha256 "378466029e9fdd7e97dcd788d96d794a789fcb4a5f4fe9904ec1a7a530401540"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1/tg_0.1.1_linux_amd64.tar.gz"
        sha256 "2ad86c0fc975bf50d227007054132a63da839657ddb4077accdf5572776b7d26"
      end
    end
  end

  def install
    resource("tarball").stage { bin.install "tg" }
  end

  def caveats
    <<~EOS
      The formula installs no service. To run the agent as a daemon (root is required):
        sudo #{HOMEBREW_PREFIX}/bin/tg service install --channel stable
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tg version")
  end
end
