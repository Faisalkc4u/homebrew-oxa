class Oxa < Formula
  desc "A powerful CLI tool for Mac"
  homepage "https://github.com/Faisalkc4u/homebrew-oxa"
  url "https://raw.githubusercontent.com/Faisalkc4u/homebrew-oxa/main/oxa.sh" # Replace "main" with your branch name if different
  version "1.0.0"
  sha256 "2bea2d52cd3dff22c9f21b5132aaf735c9c54aff646323b0e0d67a8913cd77a8"

  def install
    bin.install "oxa.sh" => "oxa"
  end
end
