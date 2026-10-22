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

  # The same steps the install script names after an install: where the
  # host runs no service, running the agent as yourself first, then the
  # service; where it does, the service alone. On a Mac the service runs
  # tg as root, so tg service install refuses a tg another account could
  # replace, as Homebrew's is: the service needs a system-wide copy, in
  # /usr/local/bin unless that directory is not root's alone, then in
  # /opt/tiefgang/bin.
  def caveats
    service_host = File.exist?("/etc/tg/agent.env")
    intro = if service_host
      "This host runs the agent as a system service; to move it onto this version, set it up again"
    else
      "On a machine of its own, run the agent as a system service instead"
    end
    if OS.mac?
      root_only = Pathname("/usr/local/bin").ascend.all? do |d|
        !d.exist? || (d.stat.uid.zero? && (d.stat.sticky? || d.stat.mode.nobits?(0022)))
      end
      dir = root_only ? "/usr/local/bin" : "/opt/tiefgang/bin"
      yourself = <<~EOS
        To run the agent as yourself: tg login, then tg
        After every `brew upgrade`, start it again on the new version: tg drain, then tg
      EOS
      (service_host ? "" : yourself) + <<~EOS
        #{intro}, from a system-wide tg (root is required; the last command names the login step):
          brew uninstall tg
          curl -fsSL https://tiefgang-releases.fsn1.your-objectstorage.com/tg/install.sh | sudo sh -s -- --install-dir #{dir} --channel stable
          sudo #{dir}/tg service install --channel stable
        The service runs tg as root, and tg service install refuses a tg another account could replace, as Homebrew's is.
      EOS
    else
      yourself = <<~EOS
        To run the agent as yourself: tg doctor --fix, then tg login, then tg
        After every `brew upgrade`, start it again on the new version: tg drain, then tg doctor --fix, then tg
      EOS
      (service_host ? "" : yourself) + <<~EOS
        #{intro} (root is required; the command names the login step):
          sudo #{HOMEBREW_PREFIX}/bin/tg service install --channel stable
        After every `brew upgrade`, run sudo #{HOMEBREW_PREFIX}/bin/tg service restart: Homebrew replaces
        the binary, not the running daemon, and the command drains the daemon and starts it again on the new version.
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tg version")
  end
end
