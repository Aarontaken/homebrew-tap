cask "sit-watcher" do
  version "1.0.4"
  sha256 :no_check

  url "https://github.com/Aarontaken/sit-watcher/releases/download/v#{version}/SitWatcher.dmg",
      verified: "github.com/Aarontaken/sit-watcher/"
  name "SitWatcher"
  desc "Menu bar sitting reminder with progressive escalation"
  homepage "https://github.com/Aarontaken/sit-watcher"

  auto_updates true

  postflight do
    app_path = "#{staged_path}/SitWatcher.app"
    target = "/Applications/SitWatcher.app"

    # Remove old version if present
    system_command "/bin/rm", args: ["-rf", target], sudo: true

    # Copy to /Applications
    system_command "/bin/cp", args: ["-R", app_path, "/Applications/"], sudo: true

    # Remove quarantine flag (Homebrew doesn't quarantine, but sigined app may trigger)
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", target], sudo: false

    # Launch the app
    system_command "/usr/bin/open", args: [target]
  end

  uninstall delete: "/Applications/SitWatcher.app"

  caveats <<~EOS
    SitWatcher is auto-installed to /Applications and launched after brew install.
    Future updates are handled automatically via Sparkle.
  EOS
end
