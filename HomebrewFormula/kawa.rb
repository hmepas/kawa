# frozen_string_literal: true

# Homebrew tap formula template for the Kawa fork.
# To use it, create a tap repository (e.g. github.com/hmepas/homebrew-kawa or homebrew-tap)
# with a `Formula` directory and drop this file in as `Formula/kawa.rb`.
class Kawa < Formula
  desc "Menu bar input source switcher with custom shortcuts"
  homepage "https://github.com/hmepas/kawa"
  url "https://github.com/hmepas/kawa.git",
      :using => :git,
      :revision => "26055edb31f2334c0575dca40b0559b47f5fdf28"
  version "0.0.1"

  depends_on :xcode => ["15.0", :build]

  def install
    system "xcodebuild",
           "-scheme", "kawa",
           "-configuration", "Release",
           "SYMROOT=build",
           "CODE_SIGN_IDENTITY=",
           "CODE_SIGNING_REQUIRED=NO"

    app_path = "build/Release/Kawa.app"
    prefix.install app_path
    bin.install_symlink "#{app_path}/Contents/MacOS/Kawa" => "kawa"
  end

  def caveats
    <<~EOS
      The app is installed to:
        #{opt_prefix}/Kawa.app
      A CLI shim is available at:
        #{opt_bin}/kawa
    EOS
  end
end
