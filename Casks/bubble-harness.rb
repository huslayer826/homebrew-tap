cask "bubble-harness" do
  version "0.1.4"
  sha256 "94bcac3b318e44f41e9ab07d1d57777f8a1cf1c8a150a87290a49c2a434a2d62"

  url "https://github.com/huslayer826/bubble-harness/releases/download/v#{version}/Bubble-Harness-arm64.dmg"
  name "Bubble Harness"
  desc "Desktop app for running coding agents side by side"
  homepage "https://github.com/huslayer826/bubble-harness"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on formula: "node"
  depends_on :macos

  app "Bubble Harness.app"

  # Not notarized yet: clear the download quarantine so Gatekeeper doesn't block the first open.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Bubble Harness.app"],
        writable_paths: ["Bubble Harness.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Application Support/dev.bubbleharness.prototype",
    "~/Library/Caches/dev.bubbleharness.prototype",
    "~/Library/HTTPStorages/dev.bubbleharness.prototype",
    "~/Library/Preferences/dev.bubbleharness.prototype.plist",
    "~/Library/Saved Application State/dev.bubbleharness.prototype.savedState",
    "~/Library/WebKit/dev.bubbleharness.prototype",
  ]
end
