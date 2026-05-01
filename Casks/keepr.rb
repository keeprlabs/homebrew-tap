# Homebrew Cask for Keepr — AI memory layer for engineering leaders.
# This formula is published at keeprlabs/homebrew-tap and auto-updated
# by the update-homebrew job in .github/workflows/release.yml.

cask "keepr" do
  version "0.2.8"
  sha256 "05f005fb513fa957d1fa6688df730b5ed3ad63cd4ce82b155f11144accf5f845"

  url "https://github.com/keeprlabs/keepr/releases/download/v#{version}/Keepr_#{version}_universal.dmg"
  name "Keepr"
  desc "AI memory layer for engineering leaders"
  homepage "https://keeprlabs.github.io/keepr"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Keepr.app"

  # Symlink the binary so `keepr` is on PATH for CLI and plugin use.
  binary "#{appdir}/Keepr.app/Contents/MacOS/Keepr", target: "keepr"

  zap trash: [
    "~/Library/Application Support/app.keepr.desktop",
    "~/Documents/Keepr",
  ]
end
