class EasyCharles < Formula
  desc "Android-first HTTP/HTTPS debugging proxy with an embedded WebUI"
  homepage "https://github.com/Aarontaken/easy-charles"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Aarontaken/easy-charles/releases/download/v0.2.0/easy-charles-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4d145467e11b51cd54defea1170e31ab4663500a63eacde7ccbeead64863b1aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Aarontaken/easy-charles/releases/download/v0.2.0/easy-charles-cli-x86_64-apple-darwin.tar.xz"
      sha256 "70285bb48bf0eb02121e4726282ab0644f95d7af44e4d1a3faae2b885ddb4f38"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Aarontaken/easy-charles/releases/download/v0.2.0/easy-charles-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dfcb9e8549940a787015b71f9f2e279b776b248d33d7787b8a1c85f101dbb4bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Aarontaken/easy-charles/releases/download/v0.2.0/easy-charles-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "273d63bde287d268b2454f8932dc93e72009ef0b292fa1806fe08e4a471b75fa"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "ec" if OS.mac? && Hardware::CPU.arm?
    bin.install "ec" if OS.mac? && Hardware::CPU.intel?
    bin.install "ec" if OS.linux? && Hardware::CPU.arm?
    bin.install "ec" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
