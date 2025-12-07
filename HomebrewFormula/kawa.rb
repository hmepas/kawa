# frozen_string_literal: true

# Homebrew tap formula template for the Kawa fork.
# To use it, create a tap repository (e.g. github.com/hmepas/homebrew-kawa or homebrew-tap)
# with a `Formula` directory and drop this file in as `Formula/kawa.rb`.
class Kawa < Formula
  desc "Menu bar input source switcher with custom shortcuts"
  homepage "https://github.com/hmepas/kawa"
  url "https://github.com/hmepas/kawa.git",
      :using => :git,
      :revision => "4e4a4fab3f1f4d57ec0a45e1c718c2dab811bf98"
  version "0.1.1"

  depends_on :xcode => ["15.0", :build]

  def install
    system "xcodebuild",
           "-scheme", "kawa",
           "-configuration", "Release",
           "-derivedDataPath", "build",
           "CODE_SIGN_IDENTITY=",
           "CODE_SIGNING_REQUIRED=NO"

    app_path = "build/Build/Products/Release/Kawa.app"
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
