# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.3.1/SHA256SUMS"
  sha256 "5e0ebadc67fee6741e1285f58c9db87c1cf352969189bcb2b9c14ec999f34ece"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.3.1/tg_0.3.1_darwin_arm64.tar.gz"
      sha256 "ed53935a38eeb3bc786dc4925c78b8d645f4a05138b1dd3f1525f59ec221472f"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.3.1/tg_0.3.1_linux_arm64.tar.gz"
        sha256 "60896726289cc2a8614dcee7070098327b38c405ec516bd97bcf4b6aa9f8de2a"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.3.1/tg_0.3.1_linux_amd64.tar.gz"
        sha256 "a9131642261d153cd148952aa2f84a215a3c41408a9c60531ce3ea3b3bc9b1da"
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
