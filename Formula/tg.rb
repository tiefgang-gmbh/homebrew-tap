# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.3.0/SHA256SUMS"
  sha256 "91b5898ddc984fea3708bcb21ca6e9d38b785dc7b54b2fcd4dffbca5bfc028b7"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.3.0/tg_0.3.0_darwin_arm64.tar.gz"
      sha256 "9240f4bd1efdc9c0dbb3f9551a58df0eb3170512ca0ecc16ebd83a80696cee51"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.3.0/tg_0.3.0_linux_arm64.tar.gz"
        sha256 "e6e2bad611557a614f2f5ffb5c3c6db7d12e08053bb7d2a14afa8b0a4c2dffc0"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.3.0/tg_0.3.0_linux_amd64.tar.gz"
        sha256 "db1535941a9a6f08c23cfd7ce9526f9e53f8f0310bf81d9d3770d95163c90c54"
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
