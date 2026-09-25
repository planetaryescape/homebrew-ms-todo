# Adapted from spotuify packaging/homebrew/spotuify.rb @ e9ec7f4f3260ba62d6dc49b7a5767259ba64bc2c
# Changes: no portaudio or extra install files; links `mst`, the official
# alias (D-039). scripts/render_homebrew_formula.sh fills in the
# placeholders, and the release workflow pushes the result to
# planetaryescape/homebrew-ms-todo.
class MsTodo < Formula
  desc "Local-first, keyboard-native terminal client for Microsoft To Do"
  homepage "https://github.com/planetaryescape/ms-todo"
  version "0.1.23"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-macos-aarch64.tar.gz"
      sha256 "1cf11a3b29bd68766fe3442ba35d3535d047369e57b0ea470296bd381c84022d"
    else
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-macos-x86_64.tar.gz"
      sha256 "213c0c525e35c4c175692074a09450b38dee81396d6958da854a2e6ef2e929fe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-linux-x86_64.tar.gz"
      sha256 "a14dcbf835bec9c9113dba9232cdb480c8d817972d5ea901f56fcb2cd486b4ad"
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
