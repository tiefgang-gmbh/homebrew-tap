# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.3/SHA256SUMS"
  sha256 "69a4f5bce06109de86708282605a0c86241d13252191c3d8dbe939e8ee49a5b7"

  on_macos do
    depends_on arch: :arm64
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.3/tg_0.1.3_darwin_arm64.tar.gz"
      sha256 "10f4d353e183e306db5d6db32ceb2be5e7e263a937192397920c5a2c4c7519ce"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.3/tg_0.1.3_linux_arm64.tar.gz"
        sha256 "a013a2b8703cff651588f310982ad8451c87933d759ed89abd7ea1becf05a5ff"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.3/tg_0.1.3_linux_amd64.tar.gz"
        sha256 "ae407182e74fdc38d0230542b2b4474a8a2dfcee4f5d86f3c287abd6772e4c34"
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
