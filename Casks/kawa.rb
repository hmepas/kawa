cask "kawa" do
  version "0.1.0"
  sha256 "a82ada37817e6bc227555a278e351e9280bdc217108b920f84f05fa9bce0dc71"

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
