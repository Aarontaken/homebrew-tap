cask "sit-watcher" do
  version "1.0.3"
  sha256 :no_check

  url "https://github.com/Aarontaken/sit-watcher/releases/download/v#{version}/SitWatcher.dmg",
      verified: "github.com/Aarontaken/sit-watcher/"
  name "SitWatcher"
  desc "Menu bar sitting reminder with progressive escalation"
  homepage "https://github.com/Aarontaken/sit-watcher"

  installer manual: "Install.app"

  uninstall delete: "/Applications/SitWatcher.app"

  caveats <<~EOS
    SitWatcher is an unsigned application. After downloading the DMG:
      1. Right-click Install.app and select "Open"
      2. Click "Open" in the Gatekeeper dialog
      3. Enter your admin password when prompted
    The installer copies SitWatcher to /Applications and launches it.
    Future updates are handled automatically via Sparkle.
  EOS
end
