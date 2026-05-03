# Homebrew formula for ctxd — context substrate for AI agents.
#
# This formula is rendered from homebrew/ctxd.rb.tmpl by
# .github/workflows/release.yml on every `v*` tag and pushed to
# keeprlabs/homebrew-tap as Formula/ctxd.rb.
#
# Install:
#   brew install keeprlabs/tap/ctxd
class Ctxd < Formula
  desc "Context substrate for AI agents — single-binary daemon, append-only event log, capabilities, MCP-native"
  homepage "https://github.com/keeprlabs/ctxd"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "9af429a1bc049c7c128a23f22aa3e7678347d9d16c52e29ccbb564260ab2886b"
    end
    on_intel do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "1d89500ed9aee1c29abae95d1255855556b26237277f4abec569d7d6ef275582"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "baa9ad2d6af46bf417cadebfa8c61862eca2e47908fb93dd3f0a6bed00e27e15"
    end
    on_intel do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d72c42e2beefa15a42ce7cf99edc21bd114204f50625d01c882203b8636d0b36"
    end
  end

  def install
    # Each tarball contains a single top-level dir (ctxd-<version>-<target>/);
    # Homebrew cd's into it before calling `install`, so the binary is at "ctxd"
    # relative to the working directory.
    bin.install "ctxd"
  end

  # `brew services start ctxd` is supported as a foreground-service
  # alternative for users who prefer Homebrew-managed services. The
  # canonical onboarding flow is `ctxd onboard`, which installs a
  # launchd plist with friendlier defaults (KeepAlive on failure
  # only, log files under ~/Library/Logs/ctxd, snapshot/restore
  # via `ctxd offboard`). Use whichever fits your operational style
  # — the two paths target different plist labels and don't conflict.
  service do
    run [opt_bin/"ctxd", "serve",
         "--db", "#{Dir.home}/Library/Application Support/ctxd/ctxd.db",
         "--bind", "127.0.0.1:7777",
         "--wire-bind", "127.0.0.1:7778"]
    keep_alive successful_exit: false
    log_path "#{Dir.home}/Library/Logs/ctxd/brew-stdout.log"
    error_log_path "#{Dir.home}/Library/Logs/ctxd/brew-stderr.log"
    working_dir "#{Dir.home}/Library/Application Support/ctxd"
  end

  def caveats
    <<~EOS
      For the full setup that wires Claude Desktop / Code / Codex
      to share memory, run:

          ctxd onboard

      It installs a managed launchd service, configures every
      MCP-aware AI tool on this machine, and seeds /me/** so a
      fresh AI conversation starts with non-empty context. See
      `ctxd onboard --help` for flags or `man ctxd` for details.

      Alternatively, `brew services start ctxd` runs the daemon
      as a Homebrew-managed service without onboarding (you'll
      need to wire MCP clients by hand).
    EOS
  end

  test do
    assert_match "ctxd", shell_output("#{bin}/ctxd --version")
  end
end
