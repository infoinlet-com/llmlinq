# LLMLinq — Claude Code plugin

Capture every prompt and response to your own machine, keep every session as a
readable transcript you can resume, and let Claude search your own knowledge
before it answers.

Everything stays local. The plugin writes to `~/.llmlinq` and talks to an MCP
server running on your machine. Nothing is uploaded unless you separately turn
on cloud sync in the app.

---

## What it does

**Captures your work.** Four lifecycle hooks record the prompt you sent, the
reply you got, and where each session started and ended.

**Saves sessions you can go back to.** Each session becomes a markdown
transcript at `~/.llmlinq/sessions/<session-id>.md`. Tell Claude *"continue the
session from ~/.llmlinq/sessions/abc123.md"* and it can pick the thread back up
— in a new session, days later, in a different repo.

**Gives Claude your context.** Sessions and anything else you have added —
notes, conventions, imported repo docs — are searchable through the bundled
`llmlinq` MCP server. Ask *"what did I work on with WordPress"* and Claude
searches your own material instead of guessing.

---

## Install

**1. Install the app** (the plugin needs it — it owns the storage, the index
and the MCP server):

```sh
curl -fsSL https://llmlinq.com/install.sh | sh
llmlinq start
```

**2. Add the plugin:**

```sh
claude plugin marketplace add infoinlet-com/llmlinq
claude plugin install llmlinq@llmlinq
```

Restart Claude Code. Check it took:

```sh
claude plugin list          # llmlinq should be enabled
claude mcp list             # llmlinq: ✔ Connected
```

That is it. Prompts are captured from your next session onward.

---

## What you get

| Component | What it is |
|---|---|
| `hooks/` | Four capture hooks — `SessionStart`, `UserPromptSubmit`, `Stop`, `SessionEnd` |
| `.mcp.json` | The `llmlinq` MCP server, started automatically |
| `skills/llmlinq/` | Tells Claude when your own knowledge is worth searching |
| `commands/` | `/llmlinq:sessions` and `/llmlinq:knowledge` |

### Tools Claude gains

| Tool | Use |
|---|---|
| `search_knowledge` | Find passages across notes, imported docs and past sessions |
| `fetch_knowledge` | Open a full document behind a promising passage |
| `list_spaces` | See what kinds of knowledge exist |

---

## How capture works

Claude Code pipes a JSON payload to a hook on each event. `hooks/capture.sh`
appends it, unparsed, to `~/.llmlinq/capture/events.jsonl`. The app reads that
file, pairs each prompt with its reply, and writes the session transcript.

```
Claude Code ──stdin──▶ capture.sh ──▶ ~/.llmlinq/capture/events.jsonl
                                              │
                                    LLMLinq app reads it
                                              │
                          ~/.llmlinq/sessions/<id>.md  ──▶ indexed, searchable
```

The fields we rely on are Claude Code's documented hook contract:

| Event | Fields used |
|---|---|
| `SessionStart` | `session_id`, `cwd`, `transcript_path`, `source` |
| `UserPromptSubmit` | `prompt`, `prompt_id`, `session_id`, `cwd` |
| `Stop` | `last_assistant_message`, `prompt_id`, `session_id` |
| `SessionEnd` | `session_id`, `reason` |

`prompt_id` is what pairs a prompt with its reply — it appears on both
`UserPromptSubmit` and `Stop`, so pairing is exact rather than guessed from
ordering or timestamps.

### Three deliberate choices

**The hook does not parse anything.** It appends bytes. Parsing lives in the
app, which you update normally — so a change to the payload shape is fixed by
an app update, not by a stale script sitting in a plugin cache.

**The hook has no dependencies.** No `jq`, no `python`, no `curl`. It runs on
every prompt in every session, so it has to work on a bare POSIX shell.

**The hook can never fail your session.** Every path exits 0. Capture is best
effort by definition and is not worth costing you a turn. If the app is not
running, events still queue in the file and are picked up later — capture works
offline and does not depend on the app being up.

---

## Privacy

Everything written by this plugin stays in `~/.llmlinq`:

```
~/.llmlinq/capture/events.jsonl     raw hook payloads
~/.llmlinq/sessions/<id>.md         readable session transcripts
~/.llmlinq/knowledge/               the searchable index
```

Your prompts and responses are recorded on your own disk. They are uploaded
only if you enable Cloud Sync in the app, which is off by default and explicit.

**Your prompts and replies are recorded verbatim**, including anything
sensitive you paste into a conversation. Two consequences worth knowing:

- Review what you keep. Sessions can be deleted from the app's Sessions view,
  or by removing the file.
- Turning capture off is `claude plugin disable llmlinq`. Existing transcripts
  stay until you delete them.

Nothing is redacted automatically. If you routinely paste credentials into
prompts, treat `~/.llmlinq` with the same care as your shell history.

---

## Troubleshooting

**No sessions appear.** Capture starts on the *next* session after install —
restart Claude Code. Then check events are arriving:

```sh
wc -l ~/.llmlinq/capture/events.jsonl
```

If that file is missing, the hooks are not running: `claude plugin list` and
confirm `llmlinq` is enabled, then `/reload-plugins`.

**Events arrive but no transcripts.** The app turns events into transcripts —
`llmlinq status` and start it if it is not running.

**`claude mcp list` shows llmlinq failing.** The MCP server is the `llmlinq`
binary; it has to be on `PATH` for Claude Code to spawn it:

```sh
which llmlinq || echo "not on PATH — see https://llmlinq.com/download"
```

**Claude does not use my knowledge unless I mention LLMLinq.** Tool selection
is a judgement, not a rule, and with many tools installed the schemas load on
demand. Make it reliable by adding a line to `~/.claude/CLAUDE.md`:

```
When the user asks about their own work, projects, setup, decisions
or anything they may have written down, search llmlinq knowledge
before answering or saying you don't know.
```

---

## Uninstall

```sh
claude plugin uninstall llmlinq
rm -rf ~/.llmlinq/capture        # optional: drop the raw event log
```

Removing the plugin stops capture. It does not delete anything already
recorded — your knowledge and transcripts remain until you remove them.

---

## Links

- [llmlinq.com](https://llmlinq.com) · [Download](https://llmlinq.com/download)
- [Releases](https://github.com/infoinlet-com/llmlinq/releases)
- Licensed under the LLMLinq EULA — see [LICENSE](../LICENSE)
