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
      sha256 "5d74396d044e931916e1c9d4e4d38be6bcc5accb09c85922ee2b43e1a8573585"
    end
    on_intel do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "096e543226eb4a497a9440a42e1f1356c8d4cad61d8f810167282c6f09d6cdb6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ae8a9e09dfe2e21499f997a1eb395f358df495fe3718f7490e5ab0dc226b69b2"
    end
    on_intel do
      url "https://github.com/keeprlabs/ctxd/releases/download/v#{version}/ctxd-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e876e2703ae89828960a701a777b45db796bc67f5bfec873cf0c79aec027a494"
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
