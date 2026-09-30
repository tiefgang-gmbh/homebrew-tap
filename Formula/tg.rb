# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.6/SHA256SUMS"
  sha256 "cb4fa0a8ebcef7c36c6c9ea88996ee9bb066188af0004a41aea6601d0d2dd6bd"

  on_macos do
    depends_on arch: :arm64
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.6/tg_0.1.6_darwin_arm64.tar.gz"
      sha256 "98bd4ead39080cf2353d04bd77ceb8f3e57bcf0ddce00dd160b0786395e54db2"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.6/tg_0.1.6_linux_arm64.tar.gz"
        sha256 "c2340c11d443739f120a412ce39ae546d02548e9133d222762d3e0f1707af192"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.1.6/tg_0.1.6_linux_amd64.tar.gz"
        sha256 "e12bf14c667e43f164a55d54c103efc7aea5e3a05013eb85f1e7ced856422c9b"
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
