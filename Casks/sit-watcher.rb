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
    user = ENV["USER"]

    # Install with a single sudo call: copy + fix ownership + remove quarantine
    system_command "/bin/bash", args: [
      "-c",
      "rm -rf '#{target}' && cp -R '#{app_path}' '/Applications/' && chown -R #{user}:staff '#{target}' && xattr -dr com.apple.quarantine '#{target}'"
    ], sudo: true

    # Launch the app as current user
    system_command "/usr/bin/open", args: [target]
  end

  uninstall delete: "/Applications/SitWatcher.app"

  caveats <<~EOS
    SitWatcher is auto-installed to /Applications and launched after brew install.
    Future updates are handled automatically via Sparkle.
  EOS
end
