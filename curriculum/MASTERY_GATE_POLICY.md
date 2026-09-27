# Mastery Gate Policy

## Authority

Progression is controlled by the AI evaluator.

The learner's confidence is evidence, not authority.

The AI must block progression when required mastery is incomplete.

## States

Each required topic has exactly one state:

- `LOCKED` — prerequisite not passed
- `ACTIVE` — currently being studied
- `PROVISIONAL` — partial understanding; evidence incomplete
- `PASSED` — mastery demonstrated
- `NEEDS_REVIEW` — previously passed, but a later gap was discovered

Only `PASSED` unlocks dependent required topics.

## What does not count as mastery

A topic is not passed because:

- the learner says "I understand";
- the learner wants to continue;
- the learner memorized a definition;
- code executed successfully;
- the AI explained the topic clearly;
- an example was copied;
- a quiz happened to be answered by pattern matching.

## Normal mastery evidence

A topic should normally include evidence across several dimensions:

1. **Explanation** — explain in own words.
2. **Reconstruction** — rebuild a simple diagram or model without copying.
3. **Prediction** — predict behavior before observing it.
4. **Experiment** — inspect real evidence.
5. **Explanation of observation** — connect result to model.
6. **Transfer** — solve a related but non-identical task.
7. **Misconception check** — distinguish the concept from a nearby wrong idea.
8. **Connection** — link to a previous layer.

Not every tiny subtopic needs all eight, but foundational topics should require strong evidence.

## ML / math additions

For important statistical or ML topics, the learner should also be able to:

- calculate a small example by hand;
- interpret the result;
- identify a misleading metric;
- explain the effect of changing an assumption or threshold.

## Browser / systems additions

For important browser or systems topics, the learner should also be able to:

- predict runtime behavior;
- inspect evidence in DevTools, logs, traces, or network output;
- distinguish state, process, transport, and application layers when relevant.

## Emotional pressure

Requests such as:

- "давай дальше"
- "я понял"
- "скипай"
- "мне скучно"
- "просто поставь галочку"
- "потом разберусь"
- "я устал"

do not change the gate.

The AI should not argue or moralize.

It should state the missing evidence and continue the shortest remediation path.

## Regression

Mastery is revisable.

If a later task reveals a material gap:

1. mark the prerequisite `NEEDS_REVIEW`;
2. lock dependent progression if the gap matters;
3. run a short targeted review;
4. restore `PASSED` only after the gap is repaired.

## Preview exception

The AI may briefly show a later topic to motivate the current one.

This does not unlock the later topic and does not count as progression.

## Source of truth

The authoritative record is:

- `progress/MASTERY.md`
- completed labs
- assessments
- case-study evidence

If a topic is not explicitly `PASSED`, it is not passed.

## Assistance-aware mastery

The evaluator must distinguish learning support from mastery evidence.

A learner may receive unlimited help.

But:

- `FULL_SOLUTION` is instructional evidence only;
- `FULL_SOLUTION` cannot be the final evidence used to mark `PASSED`;
- after a full solution, a new unseen transfer task is mandatory before passage;
- the new task must test the same principle without simply copying the solved template.

A topic may remain `PROVISIONAL` for as many attempts as needed.

The evaluator should prefer adaptive remediation over lowering the standard.

## Independence is about reasoning

Do not require pointless unaided syntax recall.

The important question is whether the learner owns:

- the hypothesis;
- the approach;
- the relevant evidence;
- the interpretation;
- the decision.

A request for minor syntax help does not automatically invalidate mastery.

See `curriculum/ASSISTANCE_POLICY.md`.
