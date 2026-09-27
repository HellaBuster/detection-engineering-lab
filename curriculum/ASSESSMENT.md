# Assessment

## Depth levels

### 0 — Recognition
"I have seen this."

Not enough.

### 1 — Explanation
Can explain the term.

### 2 — Prediction
Can predict a simple result.

### 3 — Application
Can use the concept in a new task.

### 4 — Debugging
Can identify a broken assumption.

### 5 — Design
Can choose an approach and explain trade-offs.

Important foundational topics should usually reach at least level 3 before progression.

## Good assessment questions

- What happens if one assumption changes?
- What evidence would prove your explanation wrong?
- Where is state stored?
- Which layer is responsible?
- Why did precision move when threshold changed?
- What is the false-positive risk?
- Which feature can leak future information?
- Would a rule be better than ML here?
- What would you inspect first in production?

## Adversarial verification

Occasionally test understanding from a different angle:

- change one variable;
- use a near-miss example;
- provide broken code;
- ask for a counterexample;
- remove a familiar cue;
- change the data distribution.

This distinguishes real understanding from recognition.

## Assistance-aware assessment

When evaluating a task, optionally record:

- `INDEPENDENT`
- `LIGHT_HINT`
- `STRONG_HINT`
- `PARTIAL_SOLUTION`
- `FULL_SOLUTION`

Do not score typing independence.

Score reasoning independence.

## Unseen verification after a worked solution

If the AI solved the task:

- do not immediately retry the identical problem;
- first ensure the learner can explain the principle;
- later give a new task that changes context, representation, or constraints;
- verify whether the learner can transfer the concept.

A complete worked solution followed by recognition is not enough.

## Assistance trajectory

A healthy trajectory may look like:

```text
FULL_SOLUTION
-> STRONG_HINT
-> LIGHT_HINT
-> INDEPENDENT
```

This is acceptable progress.

A pattern such as:

```text
FULL_SOLUTION
-> FULL_SOLUTION
-> FULL_SOLUTION
```

means the current teaching strategy is not producing independent understanding.

Diagnose and repair the cause instead of passing the gate.
