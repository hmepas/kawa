cask "kawa" do
  version "0.1.1"
  sha256 "6e497011580105e61d1ac6c5011fabfc90ac4cc8b45cf8547a526a62c9c870b6"

  url "https://github.com/hmepas/kawa/releases/download/v#{version}/Kawa.zip"
  name "Kawa"
  desc "Input source switcher with grouped shortcut cycling"
  homepage "https://github.com/hmepas/kawa"

  app "Kawa.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Kawa.app"],
                   sudo: false
  end

  caveats <<~EOS
    macOS may still warn about the app coming from the internet. If that happens:
      xattr -dr com.apple.quarantine /Applications/Kawa.app
  EOS

  zap trash: [
    "~/Library/Application Support/Kawa",
    "~/Library/Caches/net.noraesae.Kawa",
    "~/Library/Preferences/net.noraesae.Kawa.plist",
  ]
end
