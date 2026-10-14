# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.4.0/SHA256SUMS"
  sha256 "010364877505394547bfcca8df2246e6cf1e37183a5852b91d9f49e855b9c7d5"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.4.0/tg_0.4.0_darwin_arm64.tar.gz"
      sha256 "5007346d231f464f8d7613c10daefd1870212dabb6bd4c16b254ce3bc67859c5"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.4.0/tg_0.4.0_linux_arm64.tar.gz"
        sha256 "d415f6b472c6d4da06951cbbea7859bc56e49fcff537dd4af9da9af7222554a6"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.4.0/tg_0.4.0_linux_amd64.tar.gz"
        sha256 "ca5eb06217319f6446ec9258b8d9e2329d68e22f933b8c75401b896dc253f9b7"
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
