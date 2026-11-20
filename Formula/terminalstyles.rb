class Terminalstyles < Formula
  desc "Theme your terminal from PowerShell, zsh or bash with live-previewed styles"
  homepage "https://github.com/fcreme/TerminalStyles"
  url "https://github.com/fcreme/TerminalStyles/releases/download/v0.9.9/TerminalStyles-0.9.9.zip"
  sha256 "566fe715675c5ab79f9a07322ee1ece2eab762f4bd011bf9f2f3632eb8a03e3b"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "powershell"

  def install
    libexec.install Dir["*"]
    # TerminalStyles reads this marker to know Homebrew owns this copy: `tstyles
    # update` then points at `brew upgrade`, and `tstyles uninstall` leaves the
    # module for `brew uninstall` instead of deleting files Homebrew tracks.
    (libexec/".package-manager").write "homebrew\n"
  end

  def caveats
    <<~EOS
      To load TerminalStyles in every new PowerShell tab, run once:
        pwsh -NoProfile -Command 'Import-Module "#{opt_libexec}/TerminalStyles.psd1" -DisableNameChecking; tstyles register'

      Then open a new tab and run:
        tstyles
    EOS
  end

  test do
    psd1 = opt_libexec/"TerminalStyles.psd1"
    assert_equal "homebrew", (libexec/".package-manager").read.strip
    output = shell_output("pwsh -NoProfile -NonInteractive -Command " \
                          "\"(Import-Module '#{psd1}' -DisableNameChecking -PassThru).Version.ToString()\"")
    assert_equal version.to_s, output.strip
  end
end
