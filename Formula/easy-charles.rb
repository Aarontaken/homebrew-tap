class EasyCharles < Formula
  desc "Android-first HTTP/HTTPS debugging proxy with an embedded WebUI"
  homepage "https://github.com/Aarontaken/easy-charles"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Aarontaken/easy-charles/releases/download/v0.1.0/easy-charles-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7fb30bc147cc1989dc7143dceb6928770151e46edfa5613d924bc38c88947095"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Aarontaken/easy-charles/releases/download/v0.1.0/easy-charles-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a96ebc52c1362bceb9e3243d2bd30b42908a097c7c4036d442be0e72197c83d2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Aarontaken/easy-charles/releases/download/v0.1.0/easy-charles-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "df435e47015843423c26085647a901ffd150f792b22923212ce51f83ba2561a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Aarontaken/easy-charles/releases/download/v0.1.0/easy-charles-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9349720d71243eef6d893ec4a1d96cd6a352096f158a31e9b4202e0cd985fcbb"
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
