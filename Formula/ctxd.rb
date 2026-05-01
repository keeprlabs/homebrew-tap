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
  version "0.3.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "203adc4e92f3e2adb79ca8f97b6e7ee5e4d85519e38e68bf95b3492c849fa498"
    end
    on_intel do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "714f43b9c30dbc54f3745f3ef45d6e75b315ac50f524c602fe3d372098cc55de"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d328736e6a418296dd8d0b46c83a12d89cd004191e4c582e2105afe51aadd835"
    end
    on_intel do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3ea79071367882eb5a3b1e6a3b52a7780c8ea3f885fa86caf1c65822a50b5f93"
    end
  end

  def install
    # Each tarball contains a single top-level dir (ctxd-<version>-<target>/);
    # Homebrew cd's into it before calling `install`, so the binary is at "ctxd"
    # relative to the working directory.
    bin.install "ctxd"
  end

  test do
    assert_match "ctxd", shell_output("#{bin}/ctxd --version")
  end
end
