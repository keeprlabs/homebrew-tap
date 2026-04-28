# Homebrew Cask for Keepr — AI memory layer for engineering leaders.
# This formula is published at keeprlabs/homebrew-tap and auto-updated
# by the update-homebrew job in .github/workflows/release.yml.

cask "keepr" do
  version "0.2.5"
  sha256 "6b42d9c9335dacc24b6b8b56c571bd7fa8779d33484a3dc10f08698bc50d3bea"

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
