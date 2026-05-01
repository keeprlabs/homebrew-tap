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
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "3c3d2a09f19cf8dce19e61686a1af01d1904a52db0087baf7c4f74c496370721"
    end
    on_intel do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "43a86546b384937ee11e27c8f4b78d849a15c06fe1c77735bf37b0c73024c951"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8a9a18369d38af2ec4e63058e49966da0d193adb3c6c2ccecdea71da9bbddc42"
    end
    on_intel do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "06ad00186b3bb4c47b718dde73fc66971d1f17f99aa144e1e378a88d5779a560"
    end
  end

  def install
    bin.install "ctxd-#{version}-#{stage_target}/ctxd"
  end

  def stage_target
    if OS.mac?
      Hardware::CPU.arm? ? "aarch64-apple-darwin" : "x86_64-apple-darwin"
    else
      Hardware::CPU.arm? ? "aarch64-unknown-linux-gnu" : "x86_64-unknown-linux-gnu"
    end
  end

  test do
    assert_match "ctxd", shell_output("#{bin}/ctxd --version")
  end
end
