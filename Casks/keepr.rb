# Homebrew Cask for Keepr — AI memory layer for engineering leaders.
# This formula is published at keeprlabs/homebrew-tap and auto-updated
# by the update-homebrew job in .github/workflows/release.yml.

cask "keepr" do
  version "0.2.6"
  sha256 "eed23313f6a3d22017b36916f8d179d6a7f1130f09ad73b1efd32cbee0e7cea7"

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
