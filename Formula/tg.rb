# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2/SHA256SUMS"
  sha256 "4ad09b6518553cdf9de23822e0af3923d9d732f6fbe13a6a3f33ab77fda75c15"

  on_macos do
    depends_on arch: :arm64
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2/tg_0.1.2_darwin_arm64.tar.gz"
      sha256 "913c5074eaf6339a49f57d21e4a366e6a9d760126230cd1231f1cf13d44c683e"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2/tg_0.1.2_linux_arm64.tar.gz"
        sha256 "86f05ad98eb6fdcaf3563850256ea91965456c24fe5de8d58e991aad632ba47b"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.2/tg_0.1.2_linux_amd64.tar.gz"
        sha256 "9cd97558c7162b43e59ca9d8c69fa2d028db1e440143deb82e6485606bdb67ab"
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
