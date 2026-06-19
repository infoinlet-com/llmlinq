# LLMLinq

> Connect with **Claude Code**, **Codex CLI**, and **Gemini CLI** — then
> enhance, revise, and contextualize your prompts with AI.

LLMLinq reads the history that Claude Code, Codex CLI, and Gemini CLI already
keep on your machine and turns it into a beautiful, searchable, live-updating
timeline — running entirely on localhost. From there, one click turns any
rough prompt into a clear, specific, well-structured one.

**Website:** [llmlinq.com](https://llmlinq.com) ·
**Downloads:** [releases](https://github.com/infoinlet-com/llmlinq/releases)

This repository hosts LLMLinq's **binary releases, documentation, and issue
tracker**.

## Install

```sh
curl -fsSL https://llmlinq.com/install.sh | sh
llmlinq start        # your timeline opens at http://127.0.0.1:8745
```

- Self-contained binary — **no Python, no dependencies, no sudo**
- macOS (Apple Silicon & Intel) and Linux x86_64 · Windows coming soon
- Installs to `~/.llmlinq/app`, links `~/.local/bin/llmlinq`

## Commands

LLMLinq runs as a small background service:

```sh
llmlinq start     # start in the background and open the timeline
llmlinq status    # running? pid, URL, uptime, log file
llmlinq stop      # stop the background server
llmlinq restart   # stop + start
llmlinq upgrade   # download and install the latest release
llmlinq version   # print the version
```

The terminal stays quiet by default; full activity (including errors) is
written to a daily log file — `llmlinq status` prints its path (macOS
`~/Library/Logs/llmlinq/`, Linux `~/.local/state/llmlinq/logs/`, Windows
`%LOCALAPPDATA%\llmlinq\Logs\`). For troubleshooting, run in the foreground
with verbose logs:

```sh
llmlinq start --foreground --loglevel INFO   # run here, show INFO logs (Ctrl-C to stop)
```

## Manual install

Download the tarball for your platform from the
[latest release](https://github.com/infoinlet-com/llmlinq/releases/latest),
verify it, and put the bundle wherever you like:

```sh
curl -fsSLO https://github.com/infoinlet-com/llmlinq/releases/latest/download/llmlinq-macos-arm64.tar.gz
curl -fsSLO https://github.com/infoinlet-com/llmlinq/releases/latest/download/SHA256SUMS
shasum -a 256 -c --ignore-missing SHA256SUMS   # Linux: sha256sum -c --ignore-missing
tar -xzf llmlinq-macos-arm64.tar.gz
./llmlinq/llmlinq start
```

Assets: `llmlinq-macos-arm64.tar.gz` · `llmlinq-macos-x86_64.tar.gz` ·
`llmlinq-linux-x86_64.tar.gz` · `SHA256SUMS`

## Uninstall

```sh
llmlinq stop
rm -rf ~/.llmlinq ~/.local/bin/llmlinq
```

(`~/.llmlinq` also holds your local data — saved revisions and settings —
back it up first if you want to keep them. Logs live in the directory shown by
`llmlinq status`.)

## Privacy

Local-first by design: LLMLinq has **read-only** access to your CLI history
and binds to localhost. Nothing is uploaded unless you explicitly use AI
revision or cloud sync — both are opt-in, account-based actions over
encrypted connections. See [llmlinq.com](https://llmlinq.com) for details.

## Bugs & feature requests

Open an issue right here — this is LLMLinq's public issue tracker.

## License

LLMLinq is **proprietary software**, distributed as ready-to-run binaries under
the [LLMLinq End-User License Agreement](LICENSE). You may download and use the
software as-is; it is **not open source**, and modifying, reverse-engineering,
or redistributing it is not permitted. Bundled third-party open-source
components remain under their own licenses.
