# Adapted from spotuify packaging/homebrew/spotuify.rb @ e9ec7f4f3260ba62d6dc49b7a5767259ba64bc2c
# Changes: no portaudio or extra install files; links `mst`, the official
# alias (D-039). scripts/render_homebrew_formula.sh fills in the
# placeholders, and the release workflow pushes the result to
# planetaryescape/homebrew-ms-todo.
class MsTodo < Formula
  desc "Local-first, keyboard-native terminal client for Microsoft To Do"
  homepage "https://github.com/planetaryescape/ms-todo"
  version "0.1.17"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-macos-aarch64.tar.gz"
      sha256 "00efa596bffb4f1bc47b6500fab8e368e6d539dd8a65bf3277402dcad5f90c23"
    else
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-macos-x86_64.tar.gz"
      sha256 "de40e471cbdb4d6f202054e5853a614d3d2c187121a960ded7f9ca4825b7c92d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-linux-x86_64.tar.gz"
      sha256 "73723406b58831c7e0fe7efca34981aa34edc841456dca9a421c2f9976eef2c8"
    end
  end

  def install
    bin.install "ms-todo"
    bin.install_symlink "ms-todo" => "mst"
  end

  test do
    assert_match "ms-todo #{version}", shell_output("#{bin}/ms-todo --version")
    assert_match "ms-todo #{version}", shell_output("#{bin}/mst --version")
  end
end
