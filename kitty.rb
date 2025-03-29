class kitty < Formula
  desc "A simple CLI tool"
  homepage "https://github.com/Faisalkc4u/cli_kitty"
  url "https://github.com/Faisalkc4u/cli_kitty"
  version "1.0.0"
  sha256 "a3b2c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9c0d1e2f3"

  def install
    bin.install "kitty.sh" => "kitty"
  end
end
