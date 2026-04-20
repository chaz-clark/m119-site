# Knowledge folder

Task-scoped notes. `CLAUDE.md` is always loaded; these files are not. Claude reads a file from here when the current task matches its trigger (listed in CLAUDE.md's "Knowledge index").

**When to add a file:** a topic has enough detail that always-loading it wastes context, but it's worth keeping for when the matching task returns.

**When to update vs add:** update the existing file if the topic already has one. Don't fragment by date.

**When to drop:** if a migration/decision is fully reversed and unlikely to return, delete the file and its index entry.

Each file should open with a one-sentence description of when it applies, so Claude can confirm relevance after loading.
