---
description: List recent Claude sessions saved by LLMLinq, with the path to resume each one
---

List this user's recent LLMLinq sessions.

Read the session index at `~/.llmlinq/sessions/` — each file is
`<session-id>.md`, a markdown transcript whose front matter carries the
project, start time and prompt count.

Present the most recent 10 as a table: when, project, how many prompts, and the
first prompt as a title. Include the full path for each so the user can say
"continue the session from <path>".

If the directory is empty or missing, say so and explain that sessions are
recorded once the LLMLinq plugin is installed and the app is running — the app
is what turns captured events into these transcripts.
