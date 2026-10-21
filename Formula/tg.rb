# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.5.0/SHA256SUMS"
  sha256 "661eab704c4760d45e73db499a08837fa048333f12140663a23854d4d8488a9f"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.5.0/tg_0.5.0_darwin_arm64.tar.gz"
      sha256 "492d0f0d9f35d4f3fef556fbbd49ef48d8246df1f31d0d1ffdb52f872f5d6947"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.5.0/tg_0.5.0_linux_arm64.tar.gz"
        sha256 "ecc324b9f4f81e2f66f14dd08bbc62cb2cc6f9824da98c453a1b83aed9da7cec"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.5.0/tg_0.5.0_linux_amd64.tar.gz"
        sha256 "c8049e368da46cce1bf443fa082652539fa916bfbcf735e0b7f926cc1be535aa"
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
      After every `brew upgrade`, run sudo #{HOMEBREW_PREFIX}/bin/tg service restart: Homebrew replaces
      the binary, not the running daemon, and the command drains the daemon and starts it again on the new version.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tg version")
  end
end
