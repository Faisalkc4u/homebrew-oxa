class Oxa < Formula
  desc "Oxa CLI - A lightweight command-line tool"
  homepage "https://github.com/Faisalkc4u/homebrew-oxa"
  url "https://github.com/Faisalkc4u/homebrew-oxa/archive/refs/heads/main.zip"
  version "1.0.2"

  def install
    # Install the upgrade script
    bin.install "oxa.sh" => "oxa"
  end

  test do
    system "#{bin}/oxa", "version"
  end
end
