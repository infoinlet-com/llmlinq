#!/bin/sh
# LLMLinq capture hook.
#
# Claude Code pipes a JSON payload on stdin for every lifecycle event it fires.
# This script appends that payload, verbatim and unparsed, to a JSONL file the
# LLMLinq app owns and reads:
#
#     ~/.llmlinq/capture/events.jsonl
#
# Design notes, all deliberate:
#
#   * No jq, no python, no curl. A hook runs on every prompt in every session,
#     so it must work on a bare POSIX shell with nothing installed. Appending
#     bytes is the only operation that always succeeds.
#
#   * No parsing here. The app parses. If the payload shape ever changes, the
#     fix ships in the app the user already updates, not in a hook file sitting
#     in a plugin cache.
#
#   * Never fail. A hook that exits non-zero can interfere with the session it
#     is observing. Capture is best effort by definition: it is not worth
#     costing someone a turn. Every path exits 0.
#
#   * Append-only, single write. `>>` of a single line under PIPE_BUF is
#     atomic on POSIX, so concurrent sessions interleave cleanly rather than
#     corrupting each other's lines.
#
# Set LLMLINQ_HOME to relocate the data directory (tests, sandboxes).

set -u

home="${LLMLINQ_HOME:-$HOME/.llmlinq}"
dir="$home/capture"
file="$dir/events.jsonl"

payload=$(cat) || exit 0
[ -n "$payload" ] || exit 0

mkdir -p "$dir" 2>/dev/null || exit 0

# The payload is one JSON object; collapse any newlines so the file stays
# strictly one event per line.
printf '%s\n' "$payload" | tr -d '\n' >> "$file" 2>/dev/null || exit 0
printf '\n' >> "$file" 2>/dev/null || exit 0

exit 0
