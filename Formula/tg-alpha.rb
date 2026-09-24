# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class TgAlpha < Formula
  desc "Agent for tiefgang.sh self-hosted runners (alpha channel)"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.12/SHA256SUMS"
  version "0.1.1-alpha.12"
  sha256 "ca42901db30206d49834230e779d90b5d769756d5385029e5849cf79bba5cbd3"

  on_macos do
    depends_on arch: :arm64
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.12/tg_0.1.1-alpha.12_darwin_arm64.tar.gz"
      sha256 "c34d7dfcbbab868b8ca97925d58966d93e0d136e2faed0de50960036e2c9c609"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.12/tg_0.1.1-alpha.12_linux_arm64.tar.gz"
        sha256 "f829950aa1fa2f0f6bd857ba3063e5761acba8151eda9174f063161c7612813b"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.1-alpha.12/tg_0.1.1-alpha.12_linux_amd64.tar.gz"
        sha256 "fceda79f14137cb8f44c0bbfa7d7ee72db0566e262545f4967db78bdb53d7dda"
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
