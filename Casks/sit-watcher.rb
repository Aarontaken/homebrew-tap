cask "sit-watcher" do
  version "1.0.4"
  sha256 :no_check

  url "https://github.com/Aarontaken/sit-watcher/releases/download/v#{version}/SitWatcher.dmg",
      verified: "github.com/Aarontaken/sit-watcher/"
  name "SitWatcher"
  desc "Menu bar sitting reminder with progressive escalation"
  homepage "https://github.com/Aarontaken/sit-watcher"

  auto_updates true

  app "SitWatcher.app"

  postflight do
    system_command "/usr/bin/open", args: ["/Applications/SitWatcher.app"]
  end

  uninstall delete: "/Applications/SitWatcher.app"

  caveats <<~EOS
    Future updates are handled automatically via Sparkle.
  EOS
end
