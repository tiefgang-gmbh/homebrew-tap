# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class TgAlpha < Formula
  desc "Agent for tiefgang.sh self-hosted runners (alpha channel)"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.14/SHA256SUMS"
  version "0.1.1-alpha.14"
  sha256 "ef500f3f9b1d75d43419d7002a8237515db7e411b00870bfdab8ae7dec45233f"

  on_macos do
    depends_on arch: :arm64
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.14/tg_0.1.1-alpha.14_darwin_arm64.tar.gz"
      sha256 "fcca6519544ce25cb74afe228d32294d7ed7df2501fcf881641632f433ebe514"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.14/tg_0.1.1-alpha.14_linux_arm64.tar.gz"
        sha256 "6500c8326f5c19ad65571b88af4293a3deb3126c1d4391a91585d89ae1e7df64"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.14/tg_0.1.1-alpha.14_linux_amd64.tar.gz"
        sha256 "2aaf558d70642aa8d483ec48a6a0b3317a1f32def738834b1fdf89954288b5ca"
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
