# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.5/SHA256SUMS"
  sha256 "d1b6a973f0f8bea9d0b1ab5e4b0a79885da666083ca05bf0d6de398a9dd0d3a1"

  on_macos do
    depends_on arch: :arm64
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.5/tg_0.1.5_darwin_arm64.tar.gz"
      sha256 "91e79ddd302f03c1c267c1656b934e0a2ba04ac0f2619ee5282be1b3c0d5c2ea"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.5/tg_0.1.5_linux_arm64.tar.gz"
        sha256 "5900960619e93f7d6e2075ef72554015a128a75c54018b3cb258fa12f3218801"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.5/tg_0.1.5_linux_amd64.tar.gz"
        sha256 "546f02e5d99508a4330724bbaf5092d1968c2a11dcd860a3c72d068ce812e8b6"
      end
    end
  end

  def install
    resource("tarball").stage { bin.install "tg" }
  end

  def caveats
    <<~EOS
      The formula installs no service. To run the agent as a daemon (root is required; the command names the login step):
        sudo #{HOMEBREW_PREFIX}/bin/tg service install --channel stable
      Run the same command after every `brew upgrade`: Homebrew replaces the binary, not the
      running daemon, and the command drains the daemon and restarts it on the new version.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tg version")
  end
end
