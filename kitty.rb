class Kitty < Formula
  desc "A CLI tool for managing and interacting with Kitty"
  homepage "https://github.com/Faisalkc4u/homebrew-kitty"
  url "https://github.com/Faisalkc4u/homebrew-kitty/releases/download/v1.0.0/kitty.sh" # Update with correct URL
  version "1.0.0"
  sha256 "cf556d727452bf5518adccecefcc4b9246bf159eeda7b16f31dd88ded86762fa"

  def install
    bin.install "kitty.sh" => "kitty"
  end
end
