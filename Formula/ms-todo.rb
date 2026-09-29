# Adapted from spotuify packaging/homebrew/spotuify.rb @ e9ec7f4f3260ba62d6dc49b7a5767259ba64bc2c
# Changes: no portaudio or extra install files; links `mst`, the official
# alias (D-039). scripts/render_homebrew_formula.sh fills in the
# placeholders, and the release workflow pushes the result to
# planetaryescape/homebrew-ms-todo.
class MsTodo < Formula
  desc "Local-first, keyboard-native terminal client for Microsoft To Do"
  homepage "https://github.com/planetaryescape/ms-todo"
  version "0.1.40"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-macos-aarch64.tar.gz"
      sha256 "e675f651decab32014a5bcbddbf5be895311b25e445a4b824dd83904f799409c"
    else
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-macos-x86_64.tar.gz"
      sha256 "614613a10e23a1b801c1415c27d0e4c49cd77e57ea665eb291f9f12fed297127"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-linux-x86_64.tar.gz"
      sha256 "df18726ef8aedb59551b37e33e3e23bd7bb210ba268c4344ec9ad344088bc2b1"
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
