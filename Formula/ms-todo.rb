# Adapted from spotuify packaging/homebrew/spotuify.rb @ e9ec7f4f3260ba62d6dc49b7a5767259ba64bc2c
# Changes: no portaudio or extra install files; links `mst`, the official
# alias (D-039). scripts/render_homebrew_formula.sh fills in the
# placeholders, and the release workflow pushes the result to
# planetaryescape/homebrew-ms-todo.
class MsTodo < Formula
  desc "Local-first, keyboard-native terminal client for Microsoft To Do"
  homepage "https://github.com/planetaryescape/ms-todo"
  version "0.1.12"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-macos-aarch64.tar.gz"
      sha256 "5cf886fac30f2e350e520c43bb237bd68114e4392e36fbe1792baaedd384ff82"
    else
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-macos-x86_64.tar.gz"
      sha256 "4605d0cfb41d8146953d76c3fc7b6b06b637e8166f5676493aa30a2ff9de055a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-linux-x86_64.tar.gz"
      sha256 "3ad16995451b293c10f1ae77600f60660c2cdcf6c60494f72f071b10ff757b2e"
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
