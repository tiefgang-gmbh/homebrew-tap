# homebrew-tap

The Homebrew tap of [tiefgang.sh](https://tiefgang.sh). Two formulas,
both installing the same `bin/tg`:

    brew install tiefgang-gmbh/tap/tg          # stable
    brew install tiefgang-gmbh/tap/tg@alpha    # every release, including alphas

The formulas are written by the release workflow on every release —
nobody commits here by hand. Each formula names a prebuilt binary and
its checksum; neither installs a service. To run the agent as a daemon,
follow the formula's caveats (`tg service install`).

The release log with notes and signed artifacts is
[tiefgang-gmbh/tg-cli](https://github.com/tiefgang-gmbh/tg-cli).
