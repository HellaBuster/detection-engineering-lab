# Assistance Policy

## Principle

Help is unlimited.

Mastery credit is not.

The learner may ask for:

- a hint;
- a simpler explanation;
- a worked example;
- partial code;
- a debugging walkthrough;
- a complete solution.

The AI may provide any of these when useful.

However, assistance changes what can count as mastery evidence.

## Core rule

**A complete solution provided by the AI can never, by itself, close a mastery gate.**

If the AI performs the key reasoning, the attempt is instructional, not evaluative.

After a complete solution, the learner must face a new unseen task that tests the same underlying concept.

Only later evidence can close the gate.

## Assistance levels

Use these labels when useful:

- `INDEPENDENT` — learner performed the key reasoning without substantive help.
- `LIGHT_HINT` — small cue; learner still selected the approach and completed the reasoning.
- `STRONG_HINT` — AI substantially narrowed the approach or supplied an important intermediate step.
- `PARTIAL_SOLUTION` — AI solved a meaningful part of the task.
- `FULL_SOLUTION` — AI supplied the core reasoning or complete solution.

The label describes cognitive assistance, not typing assistance.

## Syntax help is not conceptual help

The learner may still receive `INDEPENDENT` mastery credit when the reasoning is theirs but they ask for incidental syntax.

Examples:

- "What is the exact `pandas` method name?"
- "How do I print this Playwright request header?"
- "What is the SQL syntax for a window function?"

If the learner already decided:

- what must be measured;
- why it matters;
- what approach to use;
- how to interpret the result;

then syntax help alone should not invalidate independent reasoning.

## Key reasoning test

Before deciding whether an attempt is independent, ask:

Who determined the important intellectual steps?

Examples:

### Learner-owned reasoning

The learner says:

> I think the false-positive increase may come from a threshold change. I want to compare score distributions before and after release. Show me the syntax for plotting both distributions.

This can still count as independent reasoning.

### AI-owned reasoning

The learner says:

> What is wrong? What should I inspect? Which metric should I use? Write the query. What does the result mean?

If the AI supplies all of those decisions, the attempt is not independent mastery evidence.

## Required recovery after FULL_SOLUTION

After `FULL_SOLUTION`:

1. explain the solution;
2. verify that the learner can restate the underlying idea;
3. keep the gate `PROVISIONAL` or `ACTIVE`;
4. create a new unseen task on the same underlying concept;
5. remove the previous solution as a direct template where practical;
6. evaluate the new attempt;
7. repeat with adaptive support if needed.

Do not reuse the exact same problem with only changed numbers unless the goal is a very small drill.

The new task should preserve the concept while changing context, representation, or conditions.

## Adaptive remediation

If the learner repeatedly cannot solve transfer tasks, do not simply repeat them forever.

Diagnose the cause.

Possible causes:

- missing prerequisite;
- explanation too abstract;
- task too large;
- mathematical gap;
- terminology confusion;
- inability to connect evidence to theory;
- overload from too many simultaneous concepts.

Then choose the smallest repair:

- return to a prerequisite;
- use a visual model;
- use a smaller real example;
- calculate a toy example by hand;
- demonstrate with code;
- compare two near-identical cases;
- isolate one variable.

## Assistance history

For important gates, record the recent assistance pattern.

Example:

```text
Attempt 1: FULL_SOLUTION
Attempt 2: STRONG_HINT
Attempt 3: LIGHT_HINT
Attempt 4: INDEPENDENT
```

The purpose is not punishment.

It is to detect whether independence is increasing.

## Passing rule

There is no universal requirement that every topic end with a completely unaided attempt.

The evaluator must judge whether the learner owns the important reasoning.

However:

- `FULL_SOLUTION` cannot be the final evidence;
- `PARTIAL_SOLUTION` is usually insufficient as final evidence for foundational topics;
- repeated dependence on `STRONG_HINT` requires more verification;
- a later `INDEPENDENT` or genuinely learner-led attempt is strong evidence.

## Repeated surrender

Statements such as:

- "реши за меня"
- "я сдаюсь"
- "не хочу думать"
- "просто покажи ответ"

are allowed.

The AI should help rather than moralize.

But the attempt must be recorded as assisted, and the gate remains open until later mastery evidence appears.

## Goal

The desired long-term trend is not "never ask AI for help."

It is:

**The learner increasingly owns the hypothesis, strategy, interpretation, and decision, while AI increasingly serves as an implementation and review tool.**
