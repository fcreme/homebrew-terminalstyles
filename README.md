# fcreme/homebrew-terminalstyles

The Homebrew tap for [TerminalStyles](https://github.com/fcreme/TerminalStyles).

```sh
brew install fcreme/terminalstyles/terminalstyles
```

Then, once, to load it in every new PowerShell tab:

```sh
pwsh -NoProfile -Command 'Import-Module "$(brew --prefix)/opt/terminalstyles/libexec/TerminalStyles.psd1" -DisableNameChecking; tstyles register'
```

Update with `brew upgrade terminalstyles`, remove with `brew uninstall terminalstyles`
(after `tstyles uninstall`, which takes out the shell loader and leaves the module to Homebrew).

The formula follows TerminalStyles' GitHub Releases: a daily workflow points it at the
latest release's `TerminalStyles-<version>.zip` and runs the install test.
