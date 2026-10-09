# Rendered by the tiefgang.sh release workflow on every release; never edited by hand.
class Tg < Formula
  desc "Agent for tiefgang.sh self-hosted runners"
  homepage "https://tiefgang.sh"
  url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.2.0/SHA256SUMS"
  sha256 "6ff09dd6a1b3635c690502648f511ed339203b14abc46b64161ffe7dbddc3466"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  resource "tarball" do
    on_macos do
      url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.2.0/tg_0.2.0_darwin_arm64.tar.gz"
      sha256 "f9e639684d11c478ba56e78a34c07f21fd0d9768acd043dbf82a74da34124bde"
    end
    on_linux do
      on_arm do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.2.0/tg_0.2.0_linux_arm64.tar.gz"
        sha256 "418d60051dc4f5f3623f04a3dea57ef59e407ac41b685516ae14e04d7cb0181d"
      end
      on_intel do
        url "https://tiefgang-releases.fsn1.your-objectstorage.com/tg/releases/0.2.0/tg_0.2.0_linux_amd64.tar.gz"
        sha256 "83297db2d1470a5bab651d906a1846b8305b825ff41085272e401fabd6717405"
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
