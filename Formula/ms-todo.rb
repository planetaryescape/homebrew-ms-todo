# Adapted from spotuify packaging/homebrew/spotuify.rb @ e9ec7f4f3260ba62d6dc49b7a5767259ba64bc2c
# Changes: no portaudio or extra install files; links `mst`, the official
# alias (D-039). scripts/render_homebrew_formula.sh fills in the
# placeholders, and the release workflow pushes the result to
# planetaryescape/homebrew-ms-todo.
class MsTodo < Formula
  desc "Local-first, keyboard-native terminal client for Microsoft To Do"
  homepage "https://github.com/planetaryescape/ms-todo"
  version "0.1.20"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-macos-aarch64.tar.gz"
      sha256 "14eb3b82cd6d47fa47825130359acd49b908712c27372491c634111c678e5d6b"
    else
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-macos-x86_64.tar.gz"
      sha256 "3881ddb5e7ea530e0182d368f8eb9a4bae6d6cd70b3ed7da99c9d8ccfb79f13e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/planetaryescape/ms-todo/releases/download/v#{version}/ms-todo-v#{version}-linux-x86_64.tar.gz"
      sha256 "39722bd4e6a60a629801f5e272a3baa55d74d761482d35cfd950b7efa17079b2"
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
