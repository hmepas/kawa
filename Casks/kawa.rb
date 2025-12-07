cask "kawa" do
  version "0.1.1"
  sha256 "49d1f869cf7187f284396761aa8323a051bd4c0d62bd386c47f1afe3015b2e15"

  url "https://github.com/hmepas/kawa/releases/download/v#{version}/Kawa.zip"
  name "Kawa"
  desc "Input source switcher with grouped shortcut cycling"
  homepage "https://github.com/hmepas/kawa"

  app "Kawa.app"

  zap trash: [
    "~/Library/Application Support/Kawa",
    "~/Library/Caches/net.noraesae.Kawa",
    "~/Library/Preferences/net.noraesae.Kawa.plist",
  ]
end
