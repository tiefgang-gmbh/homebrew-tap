# homebrew-tap

The Homebrew tap of [tiefgang.sh](https://tiefgang.sh). One formula,
`tg`, which follows the stable channel:

    brew install tiefgang-gmbh/tap/tg

The formula is written by the release workflow on every release —
nobody commits here by hand. It names a prebuilt binary and its
checksum and installs no service. To run the agent as a daemon, follow
the formula's caveats (`tg service install`), and run the same command
again after every `brew upgrade`.

Alpha releases are not published here. Install them with the install
script documented at <https://tiefgang.sh>.

The release log with notes and signed artifacts is
[tiefgang-gmbh/tg-cli](https://github.com/tiefgang-gmbh/tg-cli).
