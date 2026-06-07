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
llmlinq        # your timeline opens at http://127.0.0.1:8745
```

- Self-contained binary — **no Python, no dependencies, no sudo**
- macOS (Apple Silicon & Intel) and Linux x86_64 · Windows coming soon
- Installs to `~/.llmlinq/app`, links `~/.local/bin/llmlinq`
- Re-run the same command anytime to **upgrade**

## Manual install

Download the tarball for your platform from the
[latest release](https://github.com/infoinlet-com/llmlinq/releases/latest),
verify it, and put the bundle wherever you like:

```sh
curl -fsSLO https://github.com/infoinlet-com/llmlinq/releases/latest/download/llmlinq-macos-arm64.tar.gz
curl -fsSLO https://github.com/infoinlet-com/llmlinq/releases/latest/download/SHA256SUMS
shasum -a 256 -c --ignore-missing SHA256SUMS   # Linux: sha256sum -c --ignore-missing
tar -xzf llmlinq-macos-arm64.tar.gz
./llmlinq/llmlinq
```

Assets: `llmlinq-macos-arm64.tar.gz` · `llmlinq-macos-x86_64.tar.gz` ·
`llmlinq-linux-x86_64.tar.gz` · `SHA256SUMS`

## Uninstall

```sh
rm -rf ~/.llmlinq ~/.local/bin/llmlinq
```

(`~/.llmlinq` also holds your local data — saved revisions and settings —
back it up first if you want to keep them.)

## Privacy

Local-first by design: LLMLinq has **read-only** access to your CLI history
and binds to localhost. Nothing is uploaded unless you explicitly use AI
revision or cloud sync — both are opt-in, account-based actions over
encrypted connections. See [llmlinq.com](https://llmlinq.com) for details.

## Bugs & feature requests

Open an issue right here — this is LLMLinq's public issue tracker.

## License

The LLMLinq binaries are distributed under the [MIT License](LICENSE).
