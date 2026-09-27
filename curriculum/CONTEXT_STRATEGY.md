# Context Strategy

Chat history is not the source of truth.

The repository is.

## Stable context

- `AGENTS.md`
- `curriculum/`

These define how the learning system works.

## Live context

- `progress/CURRENT.md`
- `progress/MASTERY.md`
- `progress/PROGRESS.md`
- `progress/OPEN_QUESTIONS.md`
- `progress/DECISIONS.md`

These define where the learner is now.

## Experiment context

Each lab stores:

- question;
- hypothesis;
- source type;
- experiment;
- observation;
- result;
- mastery evidence.

## Project context

Each project stores:

- architecture;
- decisions;
- experiments;
- current status;
- known limitations.

## Rule

If information matters for continuation next week, it must exist in:

- the physical notebook;
- `progress/`;
- a lab;
- a project;
- a case study.

Do not rely on the AI "remembering" an old chat.

## Git

After meaningful sessions, create a commit.

Good examples:

- `learn: understand HTTP request lifecycle`
- `lab: compare browser context isolation`
- `learn: pass precision and recall gate`
- `case-study: investigate false-positive increase`
- `project: add telemetry ingestion endpoint`

## Persisting assistance dependency

When assistance materially affects a mastery decision, record it in the relevant lab and/or `progress/MASTERY.md`.

This allows a new chat or agent session to know whether the learner:

- solved independently;
- needed light guidance;
- received a worked solution;
- still needs unseen verification.

Do not rely on chat history to remember this.
