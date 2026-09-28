# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.4/SHA256SUMS"
  sha256 "cef693dbb8c293e0f0eb48e63bc9ce30aa37560861c383b35087aaead1725fbf"

  on_macos do
    depends_on arch: :arm64
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.4/tg_0.1.4_darwin_arm64.tar.gz"
      sha256 "26ca276ce8ccaacd4deffaa309cf57a8b493b0628750d2d74fc95a45ea015d71"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.4/tg_0.1.4_linux_arm64.tar.gz"
        sha256 "d16a02822799726b7c7fe548f4250dcf623d1953db3cd3c7f655a8d92decf75e"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.4/tg_0.1.4_linux_amd64.tar.gz"
        sha256 "51593a8a4503a91825ecbe3d104f6643e4e178b744bfe602b5b9d607a97d8c79"
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
