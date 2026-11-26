class Terminalstyles < Formula
  desc "Theme your terminal from PowerShell, zsh or bash with live-previewed styles"
  homepage "https://github.com/fcreme/TerminalStyles"
  url "https://github.com/fcreme/TerminalStyles/releases/download/v0.10.0/TerminalStyles-0.10.0.zip"
  sha256 "c54e0ec5e64cc9c603d84febff60015a0c80dc405ddb166f0f3ad0bfc40c1860"
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
